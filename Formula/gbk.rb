class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.4"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.4/gbk_darwin_amd64"
      sha256 "f7b1086ba8ef3072b00b3456a6af2480c87553999b855094e2196a5141af5055"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.4/gbk_darwin_arm64"
      sha256 "71968abfb5af8e385ac5b6b4f8f23ac02bee6802d3ab7fefcd99a9fc64015720"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.4/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.4/gbk_linux_amd64"
      sha256 "3fdaf7e20066a6101f26d4347bfd9225635a8c7fe7ce5d727daa3bef4edc85db"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.4/gbk_linux_arm64"
      sha256 "dda6179e603d109d10da33ab11076bcad757162a5cf6e4680a69ab9e0062207a"
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
