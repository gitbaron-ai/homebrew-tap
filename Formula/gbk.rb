class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.20"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_darwin_amd64"
      sha256 "fb5556bebea020cafb9af871bb8ed5abf2d01a65bb9baa54223bf353b0aca553"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_darwin_arm64"
      sha256 "ab87be15bcc3b40b7407430e772283d6b34c874ca72427e5b3cf2b40ef477fe4"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_linux_amd64"
      sha256 "d1f8cde682f35ef59d654edad7c6cc63d7d13131e717c67fc6f84cdf185204c3"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.20/gbk_linux_arm64"
      sha256 "0434824220e26696c3fb135585a648de2eeebde6c3afe41c3c30f6c62b9561d3"
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
