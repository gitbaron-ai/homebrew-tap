class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.4.1/gbk_darwin_amd64"
      sha256 "fd6de53407d01faa821aa7c17f2e5706838142a161ac5ec54f696a5e1598cb53"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.4.1/gbk_darwin_arm64"
      sha256 "e2193c3152661de1777d5c0b36e14d02f3df247e4cf0c43e3fbc1f242a67ff1c"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.4.1/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.4.1/gbk_linux_amd64"
      sha256 "6d1bf87df639d5f8b31fe0e519dc9ba2df9f5a8fb2aef2f9705c155463f4c493"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.4.1/gbk_linux_arm64"
      sha256 "e91e6ebc1d1149611c00d67df6e1bec0bba1a99ac427b38e5e92137168ad2d69"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
