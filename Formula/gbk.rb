class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.10-dirty"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.10-dirty/gbk_darwin_amd64"
      sha256 "8bb9525b8819d316fd3954436bb2ef800d6fddcbb4126399d8d1660a04504813"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.10-dirty/gbk_darwin_arm64"
      sha256 "509a13d137a2165f4438ea91fdeb23ed61000fadabd585b12c95e26e9c3b3744"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.10-dirty/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.10-dirty/gbk_linux_amd64"
      sha256 "e688dad6c50e5e473a4427cdfe9a8c073ca2b22504b5ee15bb0de31a62c335a4"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.10-dirty/gbk_linux_arm64"
      sha256 "953d6f3da2b95f6104539c4ac7149de72bf42927a97f341d8f0d47bc09bdc1cc"
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
