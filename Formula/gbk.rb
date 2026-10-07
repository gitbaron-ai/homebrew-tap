class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.24"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.24/gbk_darwin_amd64"
      sha256 "3dda3f350fa65dd83d291e625fd5f58e5a4819c81236dddb165db967ea57b942"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.24/gbk_darwin_arm64"
      sha256 "ebd9cb2fcc3b4cd95fddbebde2771dc223c2f366c8295bdea50672964b8da4eb"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.24/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.24/gbk_linux_amd64"
      sha256 "77fc22cfcf296717546f38a81558a2bdc56ec73ab90a3ffdd3fed725868e3874"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.24/gbk_linux_arm64"
      sha256 "41c66f0c02d1f97656a40314aa084a9dae490155c0a80ad07f3b2eaaba1eb610"
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
