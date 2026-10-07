class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.26"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.26/gbk_darwin_amd64"
      sha256 "14b53a067cf4b2b93ba73f4170a482cce04a438d860151615dada3f5f949c393"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.26/gbk_darwin_arm64"
      sha256 "e5c7065e170c6fedbb0a8a39878807e26c27b90e10c4c10d0f99cbf037ba3f7d"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.26/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.26/gbk_linux_amd64"
      sha256 "d22cc883d0dd0c74840069ee2ba880ce083b4d8fa4947d395013c09ec332b0bf"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.26/gbk_linux_arm64"
      sha256 "86a1f418b9cd4fd02146bd6e311d4924a4f809f3d2f608471e713df84d1673ff"
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
