# Homebrew tap

Apps and tools by lixsl for macOS on Apple silicon.

```sh
brew install lixsldotnet/tap/geist
brew install --cask lixsldotnet/tap/proxyard
brew install --cask lixsldotnet/tap/kubeyard
```

| Name | What | Website |
|---|---|---|
| `geist` | Geist, the coding agent for the terminal with local MLX models | https://geist.lixsl.net |
| `proxyard` | ProxYard, the Proxmox VE app | https://proxyard.net |
| `kubeyard` | KubeYard, the Kubernetes IDE | https://kubeyard.net |

Geist is a formula: `brew upgrade geist` updates it, `geist update` runs the same. The
apps are casks and update themselves. Formula and casks are written by the release script
of each project, the downloads and their SHA-256 checksums come from the project's website.

The apps are not notarized yet, so the casks remove the quarantine flag after the install.
