cask "proxyard" do
  version "0.1.5"
  sha256 "6dc59f0c9831b397a43844175f5a46e6daabdf364a88ace92bd0cce38c1377f2"

  url "https://proxyard.net/download/#{version}/ProxYard-#{version}-arm64.dmg"
  name "ProxYard"
  desc "Desktop app for Proxmox VE"
  homepage "https://proxyard.net/"

  livecheck do
    url "https://proxyard.net/api/releases"
    strategy :json do |json|
      json["latest"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "ProxYard.app"

  # The app is ad-hoc signed, not notarized yet: without this Gatekeeper blocks the first start.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/ProxYard.app"]
  end

  zap trash: [
    "~/Library/Application Support/ProxYard",
    "~/Library/Preferences/proxyard.plist",
  ]
end
