class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.33"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.33/gbk_darwin_amd64"
      sha256 "f3c04e5190e48c66e5c7a15b0a7cb1e5901a9664d2616a4835a51dea56e24313"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.33/gbk_darwin_arm64"
      sha256 "49c9b6f5cb972f0cfae793b396dea1965b49839fe6b10ef099e913f00ba08ad9"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.33/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.33/gbk_linux_amd64"
      sha256 "1843821faaecca9c7e19f38fc8c12f8721f3c540a920a25f680c93e16e547015"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.33/gbk_linux_arm64"
      sha256 "44cfb969a672eb6631546c91d11f9428853b553c30f52153bb1d4d8b291f1086"
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
