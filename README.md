# homebrew-draftly

Private Homebrew tap for [Draftly](https://draftlycad.com) — precision CAD drafting.

## Install

The artifacts live on the private `th0mps0nty/_draftly` repo, so Homebrew needs a
token that can read it:

```sh
export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
brew tap th0mps0nty/draftly
brew install --cask draftly
```

## Current build

`1.0.0` is built locally from `master` (schema v6), **ad-hoc signed and not
notarized**. The cask strips the quarantine attribute on install so the app can
launch; that stanza goes away once releases are Developer ID signed and notarized.

## Updating for a new release

The `url` points at a GitHub *asset id*, which changes on every upload. After
publishing a new build:

```sh
gh api repos/th0mps0nty/_draftly/releases/tags/<tag> --jq '.assets[]|"\(.name) \(.id)"'
shasum -a 256 <the-zip>
```

then update `version`, `sha256` and the asset id in `Casks/draftly.rb`.
