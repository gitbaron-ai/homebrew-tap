class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.22"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.22/gbk_darwin_amd64"
      sha256 "7363a518eee3e713789baefc99225f93c32e948c9143edfd304386716ca04333"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.22/gbk_darwin_arm64"
      sha256 "456e4a753d57602d0f91a5e946f13da8ce95e4fe6e771f42a3f2c4182793795b"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.22/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.22/gbk_linux_amd64"
      sha256 "69d03eefd056de6557bcda1fef8bfe2ae76268fdf23a7771c119037900c1a7cb"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.22/gbk_linux_arm64"
      sha256 "09a8fd93874814a4c26b07b6a277efce182fb9fc10c5a2b82bfcf92b52aebe53"
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
