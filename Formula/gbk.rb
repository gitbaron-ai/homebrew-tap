class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.3.0/gbk_darwin_amd64"
      sha256 "75f63770358a2fbeec62e0e042ae83104c4a12019cdbdeb3eaaffe7356c03370"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.3.0/gbk_darwin_arm64"
      sha256 "72176d64b5dccdf93257cc91fea9ca5bea1d67384bd737e2ee21c947db2cc59a"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.3.0/gbk_linux_amd64"
      sha256 "85f358d6e83ed26f7334f6cd2f11b94671a567d191af0ce107c5936a72ad78b4"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.3.0/gbk_linux_arm64"
      sha256 "300a1973ebb440e1dcbf4153bb7eb25c95c0bf61a60dd824cf9e5a3af188c4e1"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
