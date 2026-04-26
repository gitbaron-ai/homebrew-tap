class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.1-dirty"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.1-dirty/gbk_darwin_amd64"
      sha256 "8a3a8ecd9fbb6ae2e0a873a973ecc88ab955a6cc33e8539898f9421d1cd308d1"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.1-dirty/gbk_darwin_arm64"
      sha256 "a11bf347619141b7d4ccd9d22b8cf986bf0c36105aaf2c189fb8622489a7a3cd"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.1-dirty/gbk_linux_amd64"
      sha256 "f3e55a873f542fbbf3a788e0be13976d85965d8060e8db26ac2dcccb8ee078a9"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.1-dirty/gbk_linux_arm64"
      sha256 "873ad46faa7e85b96785858dd09fe0e78bcc7bf68594a32ace4f67ec8d66227e"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
