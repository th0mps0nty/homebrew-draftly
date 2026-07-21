cask "draftly" do
  version "1.0.0"
  sha256 "55dd7396577330a63ec91e38aa2b584f8b2342b58c3c229cd6287021f7dd3dbb"

  # The asset lives on the PRIVATE th0mps0nty/_draftly repo, so the plain
  # /releases/download/ URL 404s without credentials. The API asset endpoint
  # plus a token does work — set HOMEBREW_GITHUB_API_TOKEN (a classic PAT with
  # `repo` scope, or `gh auth token`) before installing.
  #
  # NOTE: the asset id is per-upload, so it changes with every release. That is
  # the price of hosting privately; publishing artifacts publicly would let this
  # be a stable versioned URL instead.
  url "https://api.github.com/repos/th0mps0nty/_draftly/releases/assets/484844146",
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")}",
      ]

  name "Draftly"
  desc "Precision CAD drafting app with AutoCAD-parity workflows"
  homepage "https://draftlycad.com/"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Draftly.app"

  # This build is AD-HOC SIGNED and NOT NOTARIZED, so Gatekeeper quarantines it
  # on any machine that did not build it. Stripping the attribute here is what
  # makes `brew install` produce a launchable app; once the release pipeline
  # signs with a Developer ID and notarizes, this stanza should be DELETED
  # rather than kept as a permanent bypass.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Draftly.app"],
                   sudo: false
  end

  uninstall quit: "com.draftlycad.app"

  zap trash: [
    "~/Library/Application Support/com.draftlycad.app",
    "~/Library/Caches/com.draftlycad.app",
    "~/Library/Preferences/com.draftlycad.app.plist",
    "~/Library/Saved Application State/com.draftlycad.app.savedState",
  ]
end
