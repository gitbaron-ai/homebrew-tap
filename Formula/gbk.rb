class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.1/gbk_darwin_amd64"
      sha256 "a72b52392bd408b3f996a571590db876522782b0e2c5c9fa30303e53f872f8cf"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.1/gbk_darwin_arm64"
      sha256 "238d43d7202bbf23246837425b8f78094618edb72813b2b9af04ecac7aee77aa"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.1/gbk_linux_amd64"
      sha256 "7d6dfa2f6480aee994c4cc396ec20d5bad7160f50c16aaa3dda0abbcc38c1fc4"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.1/gbk_linux_arm64"
      sha256 "9623e949fa6ccb4c6dd7b612b3e7323707352db4b8d5778f7bee921e2405cc1a"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
