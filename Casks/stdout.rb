# Homebrew Cask. Tap: brew tap cminhho/tap https://github.com/cminhho/homebrew-tap
# On new release of stdout: update version + sha256 (curl -sL <url> | shasum -a 256)

cask "stdout" do
  version "1.1.6"

  on_intel do
    sha256 "8752947c99ec81316419d9a43dbf6439e21db28491dbdecc29c5f06c158f0a1f"
    url "https://github.com/cminhho/stdout/releases/download/v#{version}/stdout-#{version}-mac.zip"
  end
  on_arm do
    sha256 "08d26ec5763601fefd43c7b64623aa7a29f8c508eba26f3bfd87995f6eec58c7"
    url "https://github.com/cminhho/stdout/releases/download/v#{version}/stdout-#{version}-arm64-mac.zip"
  end

  name "stdout"
  desc "Standard output for everyday dev tasks — format, transform, and generate data locally with zero server dependency"
  homepage "https://github.com/cminhho/stdout"

  app "stdout.app"

  # App is not signed; remove quarantine so macOS allows opening without "Right-click → Open"
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/stdout.app"], sudo: false
  end
end
