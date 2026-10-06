class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.20"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_darwin_amd64"
      sha256 "1417953fa89b4f1b4555c59b2439303c574e667edd623cc44eb9368dba4e85de"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_darwin_arm64"
      sha256 "8571318a35cc3576381c1934cfef61373f4d5841f8a0ab809e1a4293f0e4f14f"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_linux_amd64"
      sha256 "579052781006d909c9bef51e4d498082e3df6d67dfef91e550e552793744f5d1"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_linux_arm64"
      sha256 "7a7526c80b0056a367220e0c235f769560b18c3e440dfcf66a444564b21b411f"
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
