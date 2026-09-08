class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.11"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.11/gbk_darwin_amd64"
      sha256 "79fe290426222b1863725db847d72644cd9ca2f33f762ca87d4573e39444f3ef"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.11/gbk_darwin_arm64"
      sha256 "32904f48754df3a654e8de3e2b27764b604cabd729b4e04b9031c857c6a3ba24"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.11/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.11/gbk_linux_amd64"
      sha256 "efbf5393f29b5b808d0fb93a97ae3bec3404a195b1e6aebc5aecd1e219cb275a"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.11/gbk_linux_arm64"
      sha256 "9f175cf43353914b5ce219b575bc726c4f20c3febae1e519704b6616b74cd72d"
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
