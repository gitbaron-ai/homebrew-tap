class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.19"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.19/gbk_darwin_amd64"
      sha256 "0c2f0beed87e1356d01406bfcf41dfa0f86b25d5a682620c47f822ff7e8b2709"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.19/gbk_darwin_arm64"
      sha256 "b5cceda57245c6230781524fde59f5d3cb3fc80ab7ee07bfebfdd8d7b64cfafb"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.19/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.19/gbk_linux_amd64"
      sha256 "bc058c91a1bb28ed31c49d3fdb2db6d7f0bd0b0e0bd1af9720f1750e324c365f"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.19/gbk_linux_arm64"
      sha256 "dc8d51152f4e04c3dcd783183ab2b49aba6efc3bb9ce1645fa2290ba94677ccd"
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
