class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.0-dirty"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.0-dirty/gbk_darwin_amd64"
      sha256 "41b55cafc2a4a41411cdd35f19664e1d30fa1bf407cd8a2b61b7c52294b1ec9f"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.0-dirty/gbk_darwin_arm64"
      sha256 "9093c56e382ff02649601bc63daf387fcb82a0768884313dbd1dbe7a45558577"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.0-dirty/gbk_linux_amd64"
      sha256 "b648d78c8c648000d98a9a61629ed39c4d17752d5d02846d50279a6e7cfbcc1b"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.0-dirty/gbk_linux_arm64"
      sha256 "44cbb244e487e411fff2227f09a294b0754e3171d47773484af445a80297f46e"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
