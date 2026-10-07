class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.25"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.25/gbk_darwin_amd64"
      sha256 "985916a7e3ceeaba4f1c6ffe177b5b98e2ed4e557748899394fecbdbb86edecf"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.25/gbk_darwin_arm64"
      sha256 "ea2269405397ceebabe92e4b4e4b07b05cf29ba64359c20c1491375f33653bbc"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.25/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.25/gbk_linux_amd64"
      sha256 "7fea34ae2eb2df4b8dffd80733efddb8640960ba513e45abe21a495097755e05"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.25/gbk_linux_arm64"
      sha256 "e1a30df2ebbe10df99d1fc9c7ba7c0f0fbce80119a42c145580e7d9092beb110"
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
