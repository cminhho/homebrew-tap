# Homebrew Cask. Tap: brew tap cminhho/tap https://github.com/cminhho/homebrew-tap
# On new release of stdout: update version + sha256 (curl -sL <url> | shasum -a 256)

cask "stdout" do
  version "1.1.3"

  on_intel do
    sha256 "aaad50ebe0bc931d0a4b052d461d75837049c837d1ed46b14e942910ade71da4"
    url "https://github.com/cminhho/stdout/releases/download/v#{version}/stdout-#{version}-mac.zip"
  end
  on_arm do
    sha256 "a776be3a5d560afb6ba0214ede48db6846a0dfcfbfacb26de4e549dbf1cbdd91"
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
