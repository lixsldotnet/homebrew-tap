cask "kubeyard" do
  version "0.2.9"
  sha256 "38e15fbdba52b323089970c2671ba41859b8f70800e1f34a607e43bb190b3685"

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
  depends_on macos: :ventura

  app "KubeYard.app"

  # The app is ad-hoc signed, not notarized yet: without this Gatekeeper blocks the first start.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/KubeYard.app"]
  end

  zap trash: [
    "~/Library/Application Support/KubeYard",
    "~/Library/Preferences/kubeyard.plist",
  ]
end
