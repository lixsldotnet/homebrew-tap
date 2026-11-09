# Written by scripts/release.sh of Geist with every release; edits here are overwritten.
cask "geist" do
  version "3.0.0"
  sha256 "5086edb93fc47cd409a657c586476e16ccba1c45cb15b788b804f400b606fb2f"

  url "https://getgeist.dev/releases/#{version}/Geist-#{version}-mac-arm64.zip"
  name "Geist"
  desc "Agent workspace on the Claude Code CLI"
  homepage "https://getgeist.dev/"

  livecheck do
    url "https://getgeist.dev/releases/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Geist.app"

  # not signed by Apple yet: without this macOS calls the download damaged
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Geist.app"]
    # the `geist` command: a session in this folder (geist --temp, --resume, --continue)
    File.write("#{HOMEBREW_PREFIX}/bin/geist", "#!/bin/sh\nexec \"#{appdir}/Geist.app/Contents/Resources/bin/geistd\" open \"$@\"\n")
    File.chmod(0755, "#{HOMEBREW_PREFIX}/bin/geist")
  end

  uninstall_postflight do
    File.delete("#{HOMEBREW_PREFIX}/bin/geist") if File.exist?("#{HOMEBREW_PREFIX}/bin/geist")
  end

  zap trash: [
    "~/.geist",
    "~/Library/Application Support/Geist",
    "~/Library/LaunchAgents/dev.getgeist.geistd.plist",
  ]

  caveats <<~EOS
    Start Geist from Applications, or run geist in a project folder.
    Coding agents: read https://getgeist.dev/agents.md
  EOS
end
