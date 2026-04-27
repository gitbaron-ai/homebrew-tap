class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.7"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.7/gbk_darwin_amd64"
      sha256 "0cd739e660217a3db6415bf39681d041c18a0762d176d4777286623be67bbbde"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.7/gbk_darwin_arm64"
      sha256 "6202bafc8ebeaa2cc9ce425dc810795fcb53313aa5472f8bb202790bd666cc1c"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.7/gbk_linux_amd64"
      sha256 "a8ea56f502bb3402f75628527a314812eb0b4ae9cbcf3802180e9b2e6dd08fd5"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.7/gbk_linux_arm64"
      sha256 "89281ec24985d10404c939f12d9097a09513448b89eb4aa4ae0e2d02bed2a591"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
