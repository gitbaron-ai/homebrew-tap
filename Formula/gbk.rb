class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.28"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.28/gbk_darwin_amd64"
      sha256 "ad5790c6a1aec345672ab7b713301f3d6fe735c6ad86a124305b2bb8f96c30c8"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.28/gbk_darwin_arm64"
      sha256 "601a3b4a385a679c637c5d10bcf95cb7de7831a28940978b9eae6c6763949b79"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.28/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.28/gbk_linux_amd64"
      sha256 "557c4c25e1ed949f83fea579fec3891515599afe1cb51a764183fcc0f7a57364"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.28/gbk_linux_arm64"
      sha256 "eadbec7e12df2a058ca8b6426cdaa31bf5f8fc1d2cd7a2e7276c91ff3dfea75e"
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
