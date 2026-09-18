class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.14"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.14/gbk_darwin_amd64"
      sha256 "85fcd945d83c63c2ca4da40505c45b5b9f1796f1b800e1a5d98f3975169bdbf4"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.14/gbk_darwin_arm64"
      sha256 "1f9d52b8b68cff5ba1846048badd2bd3497594e103c7026cd90a41b0b3461afb"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.14/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.14/gbk_linux_amd64"
      sha256 "1ac0779facbc1e3bcea5c7671469c670adde6e53dc5943a277bf0e814af008ae"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.14/gbk_linux_arm64"
      sha256 "e51d93e2ec702a8924d5d3693ca914943c613c04e1e17a8353d3b39fad4556eb"
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
