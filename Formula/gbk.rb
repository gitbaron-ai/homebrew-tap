class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.21"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.21/gbk_darwin_amd64"
      sha256 "911871145b137d193af6d4beebf8a2edf5a916d6e312ed69c6caa3e25735d4d4"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.21/gbk_darwin_arm64"
      sha256 "72b4e00aa56d749341d2611c0f2ee71b3854f9f18964541e38b9db893c3713e7"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.21/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.21/gbk_linux_amd64"
      sha256 "38495c9b4975286e24e16cedd0ac5898e4b83b057b30c0fae0ac46d6826185f0"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.21/gbk_linux_arm64"
      sha256 "20baeb5b0ce5522df251fc8b8009da81f1fe3fd001fe41c485498146efa330cb"
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
