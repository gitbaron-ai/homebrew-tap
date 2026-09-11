class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.13"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.13/gbk_darwin_amd64"
      sha256 "ecc262a17658f7d5858c9b41c77d547233fa483dec7bb1e2fd732f546fde6a91"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.13/gbk_darwin_arm64"
      sha256 "4945fec90e8fe2dfc5be128db1b25ff6ea96c09741d1b0642c6785145ce1813c"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.13/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.13/gbk_linux_amd64"
      sha256 "270597103e33f749b8b158724d8b736e3c52195d1ef1abc6a61bfccf3580fa86"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.13/gbk_linux_arm64"
      sha256 "5b5be6b048c9f6c18d2c769216943db9138c815da85fd60c0c05b8e09879e8b3"
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
