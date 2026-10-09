class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.30"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.30/gbk_darwin_amd64"
      sha256 "a303f261d9f00d011c05c538ab3f6da2ebad8533c1f6ea234378307a5cb15034"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.30/gbk_darwin_arm64"
      sha256 "53b23762e1bc0d80f71fd7a04032c94ea18ceec01ede3c4d5ef174309e953b42"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.30/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.30/gbk_linux_amd64"
      sha256 "35ae1c428e9ef4351b3b89e63d5ffd0068dd0d1c38768a81da70e54d1d0ffab8"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.30/gbk_linux_arm64"
      sha256 "98dbd672f33b19fe0735529ee11f43818e7f5beb21717b6cbc547c9467c87cfc"
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
