class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.32"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.32/gbk_darwin_amd64"
      sha256 "d5d6f7eb3a200aefab881f47b81421fba5209d63b196c2d51624c722f98971b3"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.32/gbk_darwin_arm64"
      sha256 "f18092ecb957a54d2a6bf68caf45052e2953556e2cd6117a51506719d38d860e"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.32/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.32/gbk_linux_amd64"
      sha256 "63307f777649808f94c22e10fb051097624a25042a31d6b29b834972412f0748"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.32/gbk_linux_arm64"
      sha256 "629671dae2020e0935fbdd3d4dedb99ffa7e5e74dd42a3902a77e582e9fdc59c"
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
