class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.15"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.15/gbk_darwin_amd64"
      sha256 "c5250af6a81ed9ec91236b3abf17601844987d505395b4f7f6836acb2039d2c0"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.15/gbk_darwin_arm64"
      sha256 "b614410e088cc446a6000fd0ca5d4a012e05af3d3312b7252595a50bea1fcfe3"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.15/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.15/gbk_linux_amd64"
      sha256 "279ff9df86322d1a2d1578415730e2b1756d7be8f440a160ecf953340d015b2f"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.15/gbk_linux_arm64"
      sha256 "8cfd5a79150f975c9da01dc678aa257081b28301f716dba194f24bc7d6a53ae6"
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
