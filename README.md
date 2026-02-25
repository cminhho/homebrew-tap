# homebrew-tap [![Homebrew](https://img.shields.io/badge/Homebrew-tap-FBB040?style=flat&logo=homebrew)](https://brew.sh) [![GitHub](https://img.shields.io/badge/GitHub-cminhho%2Fhomebrew--tap-24292e?style=flat&logo=github)](https://github.com/cminhho/homebrew-tap)

A [Homebrew](https://brew.sh) tap providing formulae and casks by [cminhho](https://github.com/cminhho). Use this tap to install CLI tools and macOS applications that are not in the core Homebrew repos.

## Requirements

- **macOS**
- **Homebrew** — [Install](https://brew.sh) if needed

## Installation

Add the tap (required once per machine):

```bash
brew tap cminhho/tap
```

Then install any package from the [Available packages](#available-packages) section. The tap is also added automatically on first `brew install cminhho/tap/<name>`.

## Available packages

| Package     | Type    | Description |
|------------|---------|-------------|
| **cbash-cli** | Formula | A composable CLI toolkit for Bash automation. |
| **stdout**    | Cask    | Format, transform, and generate data locally; no server. Intel & Apple Silicon. |

---

### cbash-cli

Command-line tool for common dev workflows: Git, Docker, AWS, Kubernetes, and related tasks.

| Action    | Command |
|-----------|---------|
| Install   | `brew install cminhho/tap/cbash-cli` |
| Upgrade   | `brew upgrade cminhho/tap/cbash-cli` |
| Uninstall | `brew uninstall cminhho/tap/cbash-cli` |

**Upstream:** [github.com/cminhho/cbash](https://github.com/cminhho/cbash)

### stdout

Standard output for everyday dev tasks — format, transform, and generate data locally with zero server dependency. Supports Intel (x64) and Apple Silicon (arm64).

| Action    | Command |
|-----------|---------|
| Install   | `brew install --cask cminhho/tap/stdout` |
| Upgrade   | `brew upgrade --cask cminhho/tap/stdout` |
| Uninstall | `brew uninstall --cask cminhho/tap/stdout` |

**Upstream:** [github.com/cminhho/stdout](https://github.com/cminhho/stdout)

## Maintainers

To bump **stdout** (Cask) and **cbash-cli** (Formula) to the latest GitHub releases and commit:

```bash
# From repo root; needs curl, jq, shasum (macOS)
./scripts/update-casks-and-formulae.sh
# Preview only (no commit):
./scripts/update-casks-and-formulae.sh --no-commit
# Re-fetch sha256 even when version already matches:
./scripts/update-casks-and-formulae.sh --force [--no-commit]
```
