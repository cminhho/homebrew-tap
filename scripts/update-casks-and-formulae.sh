#!/usr/bin/env bash
# Update Casks/stdout.rb and Formula/cbash-cli.rb to latest GitHub release versions,
# then commit. Requires: curl, jq, shasum (macOS). Run from homebrew-tap repo root.
# Usage: ./scripts/update-casks-and-formulae.sh   [optional: --no-commit to skip git commit]

set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

NO_COMMIT=
for arg in "$@"; do
  [ "$arg" = "--no-commit" ] && NO_COMMIT=1
done

UPDATED=0

# --- stdout (Cask) ---
echo "Checking stdout..."
STDOUT_TAG=$(curl -sS "https://api.github.com/repos/cminhho/stdout/releases/latest" | jq -r '.tag_name // empty')
if [ -z "$STDOUT_TAG" ]; then
  echo "Could not get latest stdout release (rate limit or no releases?). Skipping."
else
  STDOUT_VER="${STDOUT_TAG#v}"
  CURRENT_STDOUT_VER=$(sed -n 's/^  version "\([^"]*\)".*/\1/p' Casks/stdout.rb | head -1)
  if [ "$CURRENT_STDOUT_VER" = "$STDOUT_VER" ]; then
    echo "stdout already at v${STDOUT_VER}. Skipping."
  else
    INTEL_URL="https://github.com/cminhho/stdout/releases/download/${STDOUT_TAG}/stdout-${STDOUT_VER}-mac.zip"
    ARM_URL="https://github.com/cminhho/stdout/releases/download/${STDOUT_TAG}/stdout-${STDOUT_VER}-arm64-mac.zip"
    echo "Fetching Intel zip for sha256..."
    SHA_INTEL=$(curl -sSL "$INTEL_URL" | shasum -a 256 | awk '{print $1}')
    echo "Fetching ARM zip for sha256..."
    SHA_ARM=$(curl -sSL "$ARM_URL" | shasum -a 256 | awk '{print $1}')
    sed -i '' "5s/version \"[^\"]*\"/version \"${STDOUT_VER}\"/" Casks/stdout.rb
    sed -i '' "8s/sha256 \"[^\"]*\"/sha256 \"${SHA_INTEL}\"/" Casks/stdout.rb
    sed -i '' "12s/sha256 \"[^\"]*\"/sha256 \"${SHA_ARM}\"/" Casks/stdout.rb
    echo "Updated stdout to v${STDOUT_VER} (Intel ${SHA_INTEL}, ARM ${SHA_ARM})."
    UPDATED=1
  fi
fi

# --- cbash-cli (Formula) ---
echo "Checking cbash-cli..."
CBASH_TAG=$(curl -sS "https://api.github.com/repos/cminhho/cbash/releases/latest" | jq -r '.tag_name // empty')
if [ -z "$CBASH_TAG" ]; then
  echo "Could not get latest cbash release. Skipping."
else
  CBASH_VER="${CBASH_TAG#v}"
  TARBALL_URL="https://github.com/cminhho/cbash/archive/refs/tags/${CBASH_TAG}.tar.gz"
  CURRENT_CBASH_URL=$(sed -n 's|^  url "\([^"]*\)".*|\1|p' Formula/cbash-cli.rb | head -1)
  if echo "$CURRENT_CBASH_URL" | grep -q "${CBASH_TAG}.tar.gz"; then
    echo "cbash-cli already at ${CBASH_TAG}. Skipping."
  else
    echo "Fetching cbash tarball for sha256..."
    SHA_CBASH=$(curl -sSL "$TARBALL_URL" | shasum -a 256 | awk '{print $1}')
    sed -i '' "s|^  url \"https://github.com/cminhho/cbash/archive/refs/tags/v[^\"]*\.tar\.gz\"|  url \"${TARBALL_URL}\"|" Formula/cbash-cli.rb
    sed -i '' "s/^  sha256 \"[^\"]*\"/  sha256 \"${SHA_CBASH}\"/" Formula/cbash-cli.rb
    echo "Updated cbash-cli to ${CBASH_TAG}."
    UPDATED=1
  fi
fi

if [ "$UPDATED" -eq 0 ]; then
  echo "Nothing to update."
  exit 0
fi

if [ -n "$NO_COMMIT" ]; then
  echo "Skipping git commit (--no-commit)."
  exit 0
fi

git add Casks/stdout.rb Formula/cbash-cli.rb
if git diff --cached --quiet; then
  echo "No staged changes (files already up to date?)."
  exit 0
fi
STDOUT_VER_NOW=$(sed -n 's/^  version "\([^"]*\)".*/\1/p' Casks/stdout.rb | head -1)
CBASH_VER_NOW=$(sed -n 's|^  url ".*/\(v[^"]*\)\.tar\.gz".*|\1|p' Formula/cbash-cli.rb | head -1)
git commit -m "chore: bump stdout to v${STDOUT_VER_NOW}, cbash-cli to ${CBASH_VER_NOW}"
echo "Committed. Push with: git push origin main"
exit 0
