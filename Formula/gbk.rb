class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.4.1-dirty"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.4.1-dirty/gbk_darwin_amd64"
      sha256 "4f27b5749ad7278bcec738a7c64343f6b9f21423aae6aac906250d710390b53f"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.4.1-dirty/gbk_darwin_arm64"
      sha256 "d06fa1ca920321470a2cff1bd0334c55037ad433cf30be7a043bc6f7af2719b2"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.4.1-dirty/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.4.1-dirty/gbk_linux_amd64"
      sha256 "9d71debcb902f16440ab42e352f106df9c9c9f3f925494088450c6aee4d18721"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.4.1-dirty/gbk_linux_arm64"
      sha256 "10aca2513ba449d60457b502bde5cc669044e3d596bcce1b9bcf7361f5e9931b"
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
