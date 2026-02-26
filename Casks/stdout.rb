# Homebrew Cask. Tap: brew tap cminhho/tap https://github.com/cminhho/homebrew-tap
# On new release of stdout: update version + sha256 (curl -sL <url> | shasum -a 256)

cask "stdout" do
  version "1.1.7"

  on_intel do
    sha256 "c21a154993c262541ced90c341b34dadc25a33f60b80fb88559ddde03a169032"
    url "https://github.com/cminhho/stdout/releases/download/v#{version}/stdout-#{version}-mac.zip"
  end
  on_arm do
    sha256 "08b5fab149c9ce15aa048a6b6d4c8ab5bc0528973705306f65e48c682ad6ec43"
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
