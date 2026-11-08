# Homebrew Cask for Draftly (macOS .dmg).
#
# Lives in the tap repo th0mps0nty/homebrew-draftly at Casks/draftly.rb:
#   brew install --cask th0mps0nty/draftly/draftly
#
# The DMG comes from the public th0mps0nty/draftly-releases repo; bump
# `version` and `sha256` from each Release's SHA256SUMS.txt.
cask "draftly" do
  version "1.0.12"
  sha256 "9f6bbf90cac46cf73edadf935dca8e02189aca242fb74b17a4b4d15e6f71ac5f"

  url "https://github.com/th0mps0nty/draftly-releases/releases/download/desktop-v#{version}/Draftly-#{version}.dmg"
  name "Draftly CAD"
  desc "Precision 2D CAD drafting with a command-line, object snaps, layers, and DXF"
  homepage "https://draftlycad.com/"

  # Only offer upgrades once auto-versioning is wired; until then this tracks
  # GitHub Releases.
  livecheck do
    url :url
    strategy :github_latest
    # Releases are tagged desktop-vX.Y.Z; the default pattern only reads vX.Y.Z.
    regex(/^desktop-v(\d+(?:\.\d+)+)$/i)
  end

  # Draftly requires macOS 12+. The Xcode project still says 11.0, but the
  # Flutter tooling raises the minimum deployment target to 12.0 at build time
  # ("Updating minimum macOS deployment target to 12.0" in the release job), so
  # 12 is what the shipped binary actually requires. Keep this in step with
  # packaging/downloads.json and marketing/download/index.html.
  depends_on macos: :monterey

  app "Draftly CAD.app"

  # Clean up app support/prefs on `brew uninstall --zap`.
  # The app is sandboxed (macos/Runner/Release.entitlements), so its data lives
  # under ~/Library/Containers, not directly under Application Support.
  zap trash: [
    "~/Library/Application Support/com.draftlycad.app",
    "~/Library/Containers/com.draftlycad.app",
    "~/Library/Preferences/com.draftlycad.app.plist",
    "~/Library/Saved Application State/com.draftlycad.app.savedState",
  ]
end
