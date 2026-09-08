class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.6"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.6/gbk_darwin_amd64"
      sha256 "577ace992c7927215729decc8dc7f0476228c2b430825cb012b55d26880b6324"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.6/gbk_darwin_arm64"
      sha256 "823a4bfd1495054bbeb099380ec2c9f23e07d8484598f77fe56c6090e8dec784"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.6/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.6/gbk_linux_amd64"
      sha256 "a4452a381c62bc2549e89ae5ffd85a39bda49f34caf673b48ac0b142457a3de3"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.6/gbk_linux_arm64"
      sha256 "85dedb9960deda8cdb538ec2561e6bb6fdda757aaac238424d8838242200884d"
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
