class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.4.0/gbk_darwin_amd64"
      sha256 "26919e9dc6f4468f6e0a4a58edfaec21968e89060ea1c3b2bc40f9a22aa96029"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.4.0/gbk_darwin_arm64"
      sha256 "903fe364721896a9646da89987cf0b089c6ad538b8914b34820a629cb97171d7"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.4.0/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.4.0/gbk_linux_amd64"
      sha256 "7ec417e17882ab8d09989439f244ac4f2e16a188704973281a7d73c72db022eb"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.4.0/gbk_linux_arm64"
      sha256 "ff49ab61b9e1d2bf1128bf4de6335cef3dff980dd6b6f5df6ff92d60a4aa3d0b"
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
