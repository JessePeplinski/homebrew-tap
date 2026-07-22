#!/usr/bin/env node

import { appendFile, readFile, writeFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";

const releasesApiUrl = "https://api.github.com/repos/JessePeplinski/portdeck/releases?per_page=30";
const caskUrl = new URL("../Casks/portdeck@beta.rb", import.meta.url);
const betaVersionPattern = /^\d+\.\d+\.\d+-beta\.\d+$/;
const betaTagPattern = /^v\d+\.\d+\.\d+-beta\.\d+$/;
const sha256Pattern = /^[a-f0-9]{64}$/;

function expectedAssetNames(version) {
  const zip = `PortDeck-${version}-macos-arm64.zip`;
  return { zip, checksum: `${zip}.sha256` };
}

export function selectRelease(releases, requestedVersion = "") {
  if (!Array.isArray(releases)) throw new Error("GitHub did not return a release list.");
  if (requestedVersion && !betaVersionPattern.test(requestedVersion)) {
    throw new Error(`Invalid requested beta version: ${requestedVersion}`);
  }

  const candidates = releases
    .filter((release) => {
      if (release?.draft || !release?.prerelease || typeof release?.tag_name !== "string") return false;
      if (!betaTagPattern.test(release.tag_name)) return false;
      const version = release.tag_name.replace(/^v/, "");
      return betaVersionPattern.test(version) && (!requestedVersion || version === requestedVersion);
    })
    .sort((left, right) => Date.parse(right.published_at ?? 0) - Date.parse(left.published_at ?? 0));

  for (const release of candidates) {
    const version = release.tag_name.slice(1);
    const names = expectedAssetNames(version);
    const zipAsset = release.assets?.find((asset) => asset.name === names.zip && asset.state === "uploaded");
    const checksumAsset = release.assets?.find(
      (asset) => asset.name === names.checksum && asset.state === "uploaded"
    );

    if (zipAsset && checksumAsset) return { version, zipAsset, checksumAsset };
  }

  const qualifier = requestedVersion ? ` ${requestedVersion}` : "";
  throw new Error(`No published PortDeck beta${qualifier} has both required release assets.`);
}

export function parseChecksum(contents, expectedFilename) {
  const match = contents
    .split(/\r?\n/)
    .map((line) => line.trim())
    .find((line) => line.endsWith(`  ${expectedFilename}`) || line.endsWith(` *${expectedFilename}`));

  const checksum = match?.split(/\s+/)[0] ?? "";
  if (!sha256Pattern.test(checksum)) {
    throw new Error(`The checksum asset does not contain a valid SHA-256 for ${expectedFilename}.`);
  }

  return checksum;
}

export function updateCaskContents(contents, version, checksum) {
  if (!betaVersionPattern.test(version)) throw new Error(`Invalid beta version: ${version}`);
  if (!sha256Pattern.test(checksum)) throw new Error("Invalid cask SHA-256.");

  const versionMatches = contents.match(/^\s*version "[^"]+"$/gm) ?? [];
  const checksumMatches = contents.match(/^\s*sha256 "[a-f0-9]+"$/gm) ?? [];
  if (versionMatches.length !== 1 || checksumMatches.length !== 1) {
    throw new Error("Expected exactly one version and one SHA-256 stanza in the PortDeck cask.");
  }

  const nextContents = contents
    .replace(/^\s*version "[^"]+"$/m, `  version "${version}"`)
    .replace(/^\s*sha256 "[a-f0-9]+"$/m, `  sha256 "${checksum}"`);

  return { contents: nextContents, updated: nextContents !== contents };
}

async function fetchText(url, token) {
  const headers = {
    Accept: "application/vnd.github+json",
    "User-Agent": "portdeck-homebrew-updater",
    "X-GitHub-Api-Version": "2022-11-28"
  };
  if (token) headers.Authorization = `Bearer ${token}`;

  const response = await fetch(url, { headers });
  if (!response.ok) throw new Error(`GitHub request failed (${response.status}) for ${url}`);
  return response.text();
}

async function writeOutputs(values) {
  const outputPath = process.env.GITHUB_OUTPUT;
  if (!outputPath) return;
  await appendFile(outputPath, Object.entries(values).map(([key, value]) => `${key}=${value}\n`).join(""));
}

async function main() {
  const requestedVersion = process.env.PORTDECK_RELEASE_VERSION?.trim() ?? "";
  const token = process.env.GITHUB_TOKEN?.trim() ?? "";
  const releases = JSON.parse(await fetchText(releasesApiUrl, token));
  const release = selectRelease(releases, requestedVersion);
  const names = expectedAssetNames(release.version);
  const checksumContents = await fetchText(release.checksumAsset.browser_download_url, token);
  const checksum = parseChecksum(checksumContents, names.zip);

  if (release.zipAsset.digest !== `sha256:${checksum}`) {
    throw new Error("The GitHub release digest does not match the published checksum asset.");
  }

  const currentContents = await readFile(caskUrl, "utf8");
  const next = updateCaskContents(currentContents, release.version, checksum);
  if (next.updated) await writeFile(caskUrl, next.contents);

  await writeOutputs({ updated: next.updated, version: release.version });
  console.log(
    next.updated
      ? `Updated PortDeck cask to ${release.version}.`
      : `PortDeck cask is already current at ${release.version}.`
  );
}

if (process.argv[1] && fileURLToPath(import.meta.url) === fileURLToPath(new URL(`file://${process.argv[1]}`))) {
  main().catch((error) => {
    console.error(error instanceof Error ? error.message : error);
    process.exitCode = 1;
  });
}
