# Written by the release script of Geist with every release; edits here are overwritten.
class Geist < Formula
  desc "Terminal coding agent with local MLX models and a guard model"
  homepage "https://geist.lixsl.net/"
  url "https://geist.lixsl.net/releases/geist-2.0.0-build.20261107.2-osx-arm64.tar.gz"
  version "2.0.0-build.20261107.2"
  sha256 "42fe4d18bf929e978f1ec2bf5684bdada54020f6a69170d8f8831618784cf8d1"

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
