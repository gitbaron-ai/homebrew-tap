class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.17"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.17/gbk_darwin_amd64"
      sha256 "7b0d9702f64d1462bb11b9744f918cc37df20e3d31e85874fe8075f5ccdc74f5"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.17/gbk_darwin_arm64"
      sha256 "4c16af4061af4351583d6243e55f60b1fe3aed42c4d085adb4dd61a1263fb6a7"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.17/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.17/gbk_linux_amd64"
      sha256 "8c999ab5cadbae0fb3daca6ac789746c53b02817d82a00ae6b4c257797369e4b"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.17/gbk_linux_arm64"
      sha256 "bf79bee69c96d7cd174538d3872e867f3d1f7569426496c5c14c77737bd62a04"
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
