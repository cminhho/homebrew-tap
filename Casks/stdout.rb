# Homebrew Cask. Tap: brew tap cminhho/tap https://github.com/cminhho/homebrew-tap
# On new release of stdout: update version + sha256 (curl -sL <url> | shasum -a 256)

cask "stdout" do
  version "1.1.4"

  on_intel do
    sha256 "0fbe79fe6dc4da0292c14e240d13e9cb6cfc98833df46f46c5bc934516e97818"
    url "https://github.com/cminhho/stdout/releases/download/v#{version}/stdout-#{version}-mac.zip"
  end
  on_arm do
    sha256 "d4f3b3647b5d6d64a690749922f543052acecf0b89ca098f779928078583ae96"
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
