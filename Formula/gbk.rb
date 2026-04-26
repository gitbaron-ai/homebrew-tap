class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.4-dirty"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_darwin_amd64"
      sha256 "51e173a8c6091a20348a8b5fd1ad712870d83089fe0101f6b1b2d2b88e833941"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_darwin_arm64"
      sha256 "9147397205d4299ec21e5e68cbb139da6b2527502f932b192d60eb2663e359dc"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_linux_amd64"
      sha256 "3667a5725e9b756ceae8417124f1a182f19b9bfc01128b509a133b3d26d61996"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.4-dirty/gbk_linux_arm64"
      sha256 "ffc9b55b6cffed3fdd8bbb8d16aecf3f6dcdb6db1f96c73deea1a68318940726"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
