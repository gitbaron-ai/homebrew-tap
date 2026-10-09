class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.29"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.29/gbk_darwin_amd64"
      sha256 "fad2c1821bffd496d25fa47e3cd89fa7f6b92209e199c2cc1b6c9f654b248d58"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.29/gbk_darwin_arm64"
      sha256 "0658fc35a6b46ae0e8e54398058c4ef9c1010e75cac6ebabd6891e9551e21ecc"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.29/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.29/gbk_linux_amd64"
      sha256 "f5632f6a28a4c5c4b8c64dd90f374bd8640e3bd0d8be3a0157b6ada09fd9d283"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.29/gbk_linux_arm64"
      sha256 "aaa94caf98fbb9510bc5e4888f6ba7414d55a7174afd3bbf3ca4f23b6c4be0ae"
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
