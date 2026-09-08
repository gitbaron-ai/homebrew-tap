class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.9"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.9/gbk_darwin_amd64"
      sha256 "4d188118b053652b4e48b953b988ba9f939a94c083d2ca99388115108a8b668e"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.9/gbk_darwin_arm64"
      sha256 "f3d2a1d88ad6068820d8ee893daa95e9f2469eb52ec8fbd55924e2912194c349"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.9/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.9/gbk_linux_amd64"
      sha256 "988c1ce15fc98371d1381ef3a89af66620f711926d54965e733b48897e273436"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.9/gbk_linux_arm64"
      sha256 "eae0c8a1947ad5445ce323d63afa467149f478109e8cfc3cf47a952b5b449ac1"
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
