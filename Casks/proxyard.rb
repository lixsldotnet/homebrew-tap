cask "proxyard" do
  version "0.1.7"
  sha256 "2d9a7186e48c290682ad1e0934398cd87d639276b75622f44ea4354778c68819"

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
  depends_on macos: :ventura

  app "ProxYard.app"

  # The app is ad-hoc signed, not notarized yet: without this Gatekeeper blocks the first start.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/ProxYard.app"]
  end

  zap trash: [
    "~/Library/Application Support/ProxYard",
    "~/Library/Preferences/proxyard.plist",
  ]
end
