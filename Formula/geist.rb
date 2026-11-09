# Written by the release script of Geist with every release; edits here are overwritten.
class Geist < Formula
  desc "Terminal coding agent with local MLX models and a guard model"
  homepage "https://getgeist.dev/"
  url "https://getgeist.dev/releases/geist-2.0.0-build.20261107.5-osx-arm64.tar.gz"
  version "2.0.0-build.20261107.5"
  sha256 "cd067ac0dce54194d7c88335710aca501ba3d09474c5d2e624fa6cb40a45cec5"

  livecheck do
    url "https://getgeist.dev/releases/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  disable! date: "2026-11-09", because: "is being rebuilt as Geist 3, there is no download right now"

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

      Coding agents: read https://getgeist.dev/agents.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/geist --version")
  end
end
