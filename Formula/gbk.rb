class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.4-dirty"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_darwin_amd64"
      sha256 "b2719d8a81ca519dbe4b75e11e087154234180b44b0264913839a6a6e26ad765"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_darwin_arm64"
      sha256 "ca9f167d8ce86742602cce14c278ef4f097ebfafc52d32f967c4867cd040f189"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_linux_amd64"
      sha256 "e89ea3e2c716f8dac91fec5e9f3cc2cd9281c4d7162244ade3d9e8c19a0e4216"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_linux_arm64"
      sha256 "159cc8d3d3af14c47831d4be2eea1ed218c3f48a2dda01443d87a52d82bb2200"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
