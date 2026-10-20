cask "kubeyard" do
  version "0.2.8"
  sha256 "73e46f9962d60f4b730d414fd78fbd3d0a86337d04da74c3b380c7ea22bab7c0"

  url "https://kubeyard.net/download/#{version}/KubeYard-#{version}-arm64.dmg"
  name "KubeYard"
  desc "Desktop IDE for Kubernetes clusters"
  homepage "https://kubeyard.net/"

  livecheck do
    url "https://kubeyard.net/api/releases"
    strategy :json do |json|
      json["latest"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "KubeYard.app"

  # The app is ad-hoc signed, not notarized yet: without this Gatekeeper blocks the first start.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/KubeYard.app"]
  end

  zap trash: [
    "~/Library/Application Support/KubeYard",
    "~/Library/Preferences/kubeyard.plist",
  ]
end
