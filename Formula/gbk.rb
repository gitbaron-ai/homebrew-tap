class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.27"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.27/gbk_darwin_amd64"
      sha256 "0da84b61446628c1ef5e6b8419d1fbd56f31ede53953af565ed6ba25e7620f3e"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.27/gbk_darwin_arm64"
      sha256 "55cee00d87e7de2bba7f16942f0558ab113813c833f2b1a6c1f414a90adb2cd3"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.27/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.27/gbk_linux_amd64"
      sha256 "51a5e69b37553253de539ab66d23ddc71b7615101810a89fe3354e18e5697e54"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.27/gbk_linux_arm64"
      sha256 "814d16995a11ac81718af03bfb7ed69a2b3dbcf512aee54131501bf3ddf3a940"
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
