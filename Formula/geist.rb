# Written by the release script of Geist with every release; edits here are overwritten.
class Geist < Formula
  desc "Terminal coding agent with local MLX models and a guard model"
  homepage "https://getgeist.dev/"
  url "https://getgeist.dev/releases/geist-2.0.0-build.20261107.3-osx-arm64.tar.gz"
  version "2.0.0-build.20261107.3"
  sha256 "6919aec761b7406e712c7adc52e47e39e6bb4d4570120a358ab3a2d70e22178d"

  livecheck do
    url "https://getgeist.dev/releases/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "geist"
  end

  def caveats
    <<~EOS
      Start geist in a project folder; the first start runs the setup.
      geist update runs brew update and brew upgrade geist.
      Config, runtime, models and sessions live in ~/.geist: remove that folder
      after brew uninstall geist to remove everything.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/geist --version")
  end
end
