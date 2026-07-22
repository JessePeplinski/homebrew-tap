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
2. Update `version` and `sha256` in `Casks/portdeck@beta.rb`.
3. Run `brew style`, `brew audit`, and a clean install/uninstall test.
4. Commit and push the tested cask update.

See the [PortDeck repository](https://github.com/JessePeplinski/portdeck) for
source, release notes, and manual downloads.
