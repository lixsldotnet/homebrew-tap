# Written by the release script of Geist with every release; edits here are overwritten.
cask "geist" do
  version "2.0.0-build.20261111.6"
  sha256 "020813a4c5502b5f3aa2a07f895096bfede881662b479965e74fc3cddaa50026"

  url "https://getgeist.dev/releases/Geist-2.0.0-build.20261111.6-osx-arm64.zip"
  name "Geist"
  desc "Local coding agent: a terminal harness and a desktop app on one daemon, local MLX models"
  homepage "https://getgeist.dev/"

  livecheck do
    url "https://getgeist.dev/releases/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Geist.app"
  binary "#{appdir}/Geist.app/Contents/Resources/app/bin/geist"

  # Unsigned for now (app plan D9): the quarantine flag would make macOS refuse to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Geist.app"]
  end

  uninstall quit: "dev.getgeist.app",
            launchctl: "dev.getgeist.geistd"

  zap trash: [
    "~/.geist",
    "~/Library/LaunchAgents/dev.getgeist.geistd.plist",
    "~/Library/WebKit/dev.getgeist.app",
    "~/Library/Caches/dev.getgeist.app",
  ]

  caveats <<~EOS
    Geist.app and the geist command share one daemon (geistd) and ~/.geist: config,
    runtime, models and sessions. brew upgrade geist updates both.
    brew uninstall --zap geist removes ~/.geist too.
  EOS
end
