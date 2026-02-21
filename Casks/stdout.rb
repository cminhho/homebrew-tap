# Homebrew Cask. Tap: brew tap cminhho/tap https://github.com/cminhho/homebrew-tap
# On new release of stdout: update version + sha256 (curl -sL <url> | shasum -a 256)

cask "stdout" do
  version "1.0.0"
  sha256 "5b4f86769c5749e4ea3b1805c805a5605154c94056bb6206357e0e1e59b24b01"

  url "https://github.com/cminhho/stdout/releases/download/v#{version}/stdout-#{version}-mac.zip"
  name "stdout"
  desc "Your standard output for dev tools — formatters, converters, generators, encode/decode"
  homepage "https://github.com/cminhho/stdout"

  app "stdout.app"

  # App is not signed; remove quarantine so macOS allows opening without "Right-click → Open"
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/stdout.app"], sudo: false
  end
end
