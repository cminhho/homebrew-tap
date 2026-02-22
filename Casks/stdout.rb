# Homebrew Cask. Tap: brew tap cminhho/tap https://github.com/cminhho/homebrew-tap
# On new release of stdout: update version + sha256 (curl -sL <url> | shasum -a 256)

cask "stdout" do
  version "1.1.2"

  on_intel do
    sha256 "44b99f65d7bf82ffde72621f1c317eed11e39013608d6e2b6e0910999bb6b40e"
    url "https://github.com/cminhho/stdout/releases/download/v#{version}/stdout-#{version}-mac.zip"
  end
  on_arm do
    sha256 "a597955f950199e2838a17517362873e58fa23138926c7d8bed17d3df576b059"
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
