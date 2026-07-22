# PortDeck Homebrew Tap

This tap installs the signed and Apple-notarized PortDeck macOS app from its
versioned GitHub Release.

## Install

PortDeck currently requires an Apple Silicon Mac running macOS 14 Sonoma or
newer.

```bash
brew install --cask JessePeplinski/tap/portdeck@beta
```

Launch PortDeck from Applications or run:

```bash
open -a PortDeck
```

Homebrew will include PortDeck when checking for cask upgrades. You can also
upgrade it explicitly:

```bash
brew upgrade --cask JessePeplinski/tap/portdeck@beta
```

## Maintainer release checklist

1. Publish and verify the new signed, notarized PortDeck GitHub Release.
2. Run the `Update PortDeck cask` workflow for the exact beta version and confirm it succeeds.
3. Confirm the cask commit reached `main`, then run a clean public install/uninstall smoke test.

The workflow also checks for a newer published PortDeck beta every six hours. It accepts only a non-draft prerelease with both expected arm64 assets, requires the GitHub asset digest to match the published SHA-256 sidecar, audits the updated cask, and commits only after those checks pass.

See the [PortDeck repository](https://github.com/JessePeplinski/portdeck) for
source, release notes, and manual downloads.
