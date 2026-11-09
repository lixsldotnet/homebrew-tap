# Written by the release script of Geist with every release; edits here are overwritten.
class Geist < Formula
  desc "Terminal coding agent with local MLX models and a guard model"
  homepage "https://getgeist.dev/"
  url "https://getgeist.dev/releases/geist-2.0.0-build.20261109-osx-arm64.tar.gz"
  version "2.0.0-build.20261109"
  sha256 "45a52e22295f90a7ba6815c761e5f3025995fc7d9e0426b02f42edc0480690bd"

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
