class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.6.0/gbk_darwin_amd64"
      sha256 "957661e54b03511c0907bdf9a913ac475c1c66927a819dbe3b3c0f9329cd332e"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.6.0/gbk_darwin_arm64"
      sha256 "4ff14dabf0bb49a3774dedcdfc424e7d5410ab0ae63c82662722cb6006adf6df"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.6.0/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.6.0/gbk_linux_amd64"
      sha256 "924a47cef641919181fbc7c73d86e57a91caac561f973e95ce5a4f3bbedd0b29"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.6.0/gbk_linux_arm64"
      sha256 "f5c085a9d4bdf3eadbd8914f2cb38f6b5ec549586f2b374ce37a33f2dbca719b"
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
