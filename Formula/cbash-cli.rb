# Homebrew formula. Tap: brew tap cminhho/tap https://github.com/cminhho/homebrew-tap
# On new release of cbash: update url + sha256 (curl -sL <url> | shasum -a 256)

class CbashCli < Formula
  desc "Command-line tools for developers (macOS/Linux)"
  homepage "https://github.com/cminhho/cbash"
  url "https://github.com/cminhho/cbash/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "dfb73782da6fc51631373ecb9a038a16938f9095357800187228c7a7c67c6f08"
  license "MIT"
  head "https://github.com/cminhho/cbash.git", branch: "master"

  depends_on "bash"

  def install
    libexec.install Dir["*"]
    (bin/"cbash").write <<~EOS
      #!/usr/bin/env bash
      export CBASH_DIR="#{libexec}"
      exec "#{libexec}/cbash.sh" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Optional: add to ~/.zshrc for aliases and plugins (CBASH_DIR is set automatically):
        source "#{opt_libexec}/cbash.sh"
    EOS
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/cbash 2>&1")
  end
end
