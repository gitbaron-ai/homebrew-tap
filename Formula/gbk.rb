class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gitbaron-ai/gbk/releases/download/v0.7.0/gbk_darwin_amd64"
      sha256 "2a207d3839deef7269b4d029c11bc90df5c0d964306ef09c5d4b629f63e28850"
    end
    on_arm do
      url "https://github.com/gitbaron-ai/gbk/releases/download/v0.7.0/gbk_darwin_arm64"
      sha256 "9b5098ceeff4397e22c699651477d2d38a2d63e0921bc5a6116b251c6cd6d290"
      resource "gbk-applellm" do
        url "https://github.com/gitbaron-ai/gbk/releases/download/v0.7.0/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gitbaron-ai/gbk/releases/download/v0.7.0/gbk_linux_amd64"
      sha256 "82b710160bed12058f6100e5fa29663322f313aa248c660178467280f6455e9d"
    end
    on_arm do
      url "https://github.com/gitbaron-ai/gbk/releases/download/v0.7.0/gbk_linux_arm64"
      sha256 "043a5b7b498bef6d5ee88cfc75913045408d5891722334ab2ae615d916af278b"
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
