class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.31"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.31/gbk_darwin_amd64"
      sha256 "1569aae5fdb2dc1196be174508d0bbb96cf0112236e85315cea8f788e23e8c5a"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.31/gbk_darwin_arm64"
      sha256 "d88ea530f53a3ea69f62562ca07bd20a886963b180a043f019b3095f72053798"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.31/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.31/gbk_linux_amd64"
      sha256 "417341c803adaebb1ae62709cd0d8d691dbd20159245a475addf3cbc6daf9fd2"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.31/gbk_linux_arm64"
      sha256 "2995094aa6ec87a960bff8c27a397c4360dbf77cdcf98b43934974183117d9e3"
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
