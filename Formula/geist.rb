# Written by the release script of Geist with every release; edits here are overwritten.
class Geist < Formula
  desc "Terminal coding agent with local MLX models and a guard model"
  homepage "https://geist.lixsl.net/"
  url "https://geist.lixsl.net/releases/geist-2.0.0-build.20261107-osx-arm64.tar.gz"
  version "2.0.0-build.20261107"
  sha256 "3d8697c4ca9c88b7a59a97704821a5f7d2ed8a80689919d48aa152759fb491c0"

  livecheck do
    url "https://geist.lixsl.net/releases/latest.json"
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
