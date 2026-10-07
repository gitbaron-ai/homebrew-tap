class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.23"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.23/gbk_darwin_amd64"
      sha256 "6bd06d7d335dad02ddf4b28fdffc88e10bf8e917b7473d66116e9fe89fb0c410"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.23/gbk_darwin_arm64"
      sha256 "3d29dada1d061694cf775bf31f35f2731d52b0e1585fa7f529351435bbd00e81"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.23/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.23/gbk_linux_amd64"
      sha256 "c3ec61ab857a198bbf679be5b3a3bc8268b548c6df2d602f1c418228873ca511"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.23/gbk_linux_arm64"
      sha256 "39eebda2d2f56e2635b9b902ea8814dda75fb01d2c7f4b10dedc991aa966d6ae"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
    if OS.mac? && Hardware::CPU.arm?
      resource("gbk-applellm").stage do
        bin.install "gbk-applellm_darwin_arm64" => "gbk-applellm"
      end
      chmod 0755, bin/"gbk-applellm"
    end
  end

  def post_install
    # brew upgrade deletes the old Cellar inode; re-register MCP commands
    ohai "Refreshing GitBaron MCP registration (gbk install)"
    system bin/"gbk", "install" or true
  rescue
    true
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
