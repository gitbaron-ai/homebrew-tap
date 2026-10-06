class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.18"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.18/gbk_darwin_amd64"
      sha256 "fc2df98388453b39c7fcf7a884fc24defbfbe08146e0e39787caf17002e4c1d2"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.18/gbk_darwin_arm64"
      sha256 "093c78dbb88abdaa514f2a8cb57e9eb3980e7b34a2be56993c64146a178a1d6b"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.18/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.18/gbk_linux_amd64"
      sha256 "1cd5c03fb73eadaaa2daf80e1004e65a62d12775f697b5d7f01c937181604dc9"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.18/gbk_linux_arm64"
      sha256 "3064b1f9c35060d9d0cc1bd35557f4f0ce6df6ca26d67bebf615f8b157aa2085"
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
