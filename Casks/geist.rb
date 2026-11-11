# Written by the release script of Geist with every release; edits here are overwritten.
cask "geist" do
  version "2.0.0-build.20261111.2"
  sha256 "e950ebb65c5e559ef5431c74fd1bd97fdc65a6f858a4f41e49c98cb9b6a700b3"

  url "https://getgeist.dev/releases/Geist-2.0.0-build.20261111.2-osx-arm64.zip"
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
