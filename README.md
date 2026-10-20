# Homebrew tap

macOS apps by lixsl, Apple silicon.

```sh
brew install --cask lixsldotnet/tap/proxyard
brew install --cask lixsldotnet/tap/kubeyard
```

| Cask | App | Website |
|---|---|---|
| `proxyard` | ProxYard, the Proxmox VE app | https://proxyard.net |
| `kubeyard` | KubeYard, the Kubernetes IDE | https://kubeyard.net |

The apps update themselves. The casks are updated by the release script of each app, the
downloads and their SHA-256 checksums come from the app's website.

The apps are not notarized yet, so the casks remove the quarantine flag after the install.
