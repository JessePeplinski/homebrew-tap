import assert from "node:assert/strict";
import test from "node:test";

import { parseChecksum, selectRelease, updateCaskContents } from "./update-portdeck-cask.mjs";

const beta1 = release("0.1.0-beta.1", "2026-07-21T20:00:00Z");
const beta2 = release("0.1.0-beta.2", "2026-07-21T23:00:00Z");

test("selects the newest published beta with both assets", () => {
  assert.equal(selectRelease([beta1, beta2]).version, "0.1.0-beta.2");
});

test("selects an explicitly requested beta", () => {
  assert.equal(selectRelease([beta1, beta2], "0.1.0-beta.1").version, "0.1.0-beta.1");
});

test("rejects drafts, stable releases, unprefixed tags, and incomplete betas", () => {
  assert.throws(
    () =>
      selectRelease([
        { ...beta2, draft: true },
        { ...beta2, prerelease: false },
        { ...beta2, tag_name: "0.1.0-beta.2" },
        { ...beta2, assets: beta2.assets.slice(0, 1) }
      ]),
    /both required release assets/
  );
});

test("parses only the checksum for the expected asset", () => {
  const checksum = "a".repeat(64);
  assert.equal(parseChecksum(`${"b".repeat(64)}  other.zip\n${checksum}  PortDeck.zip\n`, "PortDeck.zip"), checksum);
  assert.throws(() => parseChecksum(`${checksum}  other.zip\n`, "PortDeck.zip"), /valid SHA-256/);
});

test("updates exactly the version and checksum stanzas", () => {
  const checksum = "c".repeat(64);
  const current = `cask "portdeck@beta" do\n  version "0.1.0-beta.1"\n  sha256 "${"a".repeat(64)}"\nend\n`;
  const next = updateCaskContents(current, "0.1.0-beta.2", checksum);

  assert.equal(next.updated, true);
  assert.match(next.contents, /version "0\.1\.0-beta\.2"/);
  assert.match(next.contents, new RegExp(`sha256 "${checksum}"`));
});

function release(version, publishedAt) {
  const zipName = `PortDeck-${version}-macos-arm64.zip`;
  return {
    draft: false,
    prerelease: true,
    published_at: publishedAt,
    tag_name: `v${version}`,
    assets: [
      { name: zipName, state: "uploaded", digest: `sha256:${"a".repeat(64)}` },
      { name: `${zipName}.sha256`, state: "uploaded", browser_download_url: "https://example.com/checksum" }
    ]
  };
}
