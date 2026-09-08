class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.10"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.10/gbk_darwin_amd64"
      sha256 "e9fe22a51a21c8a0f69028d7fe3452c5ac8cc29d590310a6cb4e51a241941d8d"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.10/gbk_darwin_arm64"
      sha256 "1ec548e98047f456492e04c402fd44f1f64c80bac43d130bd8891e4ce6a2c412"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.10/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.10/gbk_linux_amd64"
      sha256 "cde83da6e129d753eb803f8d9f9678f50b2f145a9c251cc62723527246c8691f"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.10/gbk_linux_arm64"
      sha256 "3bb02194e290f729bb53cbd57795c2e7c468687f127959e72c35a7d155ce88d0"
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
