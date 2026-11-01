# homebrew-draftly

Homebrew tap for [Draftly CAD](https://draftlycad.com), precision 2D CAD drafting.

## Install

```sh
brew install --cask th0mps0nty/draftly/draftly
```

The tap repo is private for now, so tapping needs GitHub access to it. The DMG
itself comes from the public
[draftly-releases](https://github.com/th0mps0nty/draftly-releases/releases/latest)
repo and is Developer ID signed and notarized. macOS 12 or later, Apple Silicon
and Intel.

## Updating for a new release

Copy `packaging/homebrew/draftly.rb` from the app repo after bumping `version`
and `sha256` from the release's `SHA256SUMS.txt`.
