# Written by scripts/release.sh of Geist with every release; edits here are overwritten.
cask "geist" do
  version "3.1.0"
  sha256 "3e6eae173d34dd44c20b5904b22cf912c258d0c38a3e007d02a4f90b568c8bbf"

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
  depends_on macos: :ventura

  app "Geist.app"

  app_path = "#{appdir}/Geist.app"

  # not signed by Apple yet: without this macOS calls the download damaged; then the `geist`
  # command (a session in this folder: geist --temp, --resume, --continue)
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", app_path], writable_paths: [app_path], must_succeed: false
    write_file "bin/geist", "#!/bin/sh\nexec \"#{app_path}/Contents/Resources/app/geistd\" open \"$@\"\n", base: :homebrew_prefix
    set_permissions "bin/geist", "0755", base: :homebrew_prefix, recursive: false
  end

  uninstall_postflight_steps do
    remove "bin/geist", base: :homebrew_prefix
  end

  # brew uninstall --zap --cask geist: everything Geist left, like install.sh's remove
  uninstall launchctl: "dev.getgeist.geistd"

  zap trash: [
    "~/.geist",
    "~/Library/LaunchAgents/dev.getgeist.geistd.plist",
    "~/Library/WebKit/dev.getgeist.desktop",
    "~/Library/Caches/dev.getgeist.desktop",
    "~/Library/Application Support/dev.getgeist.desktop",
    "~/Library/HTTPStorages/dev.getgeist.desktop",
    "~/Library/Saved Application State/dev.getgeist.desktop.savedState",
    "~/Library/Preferences/dev.getgeist.desktop.plist",
    "~/Library/Application Support/Geist",
  ]

  caveats <<~EOS
    Start Geist from Applications, or run geist in a project folder.
    Coding agents: read https://getgeist.dev/agents.md
  EOS
end
