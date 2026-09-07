class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.3/gbk_darwin_amd64"
      sha256 "00fb57d324b28ea4942f9de6fa33bacbc0ca7313848382d79647547f40a8d75a"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.3/gbk_darwin_arm64"
      sha256 "fca0b862c7bd7c94edeb808de2f939f1e404190fa5f273767e0d3410427b0c7d"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.3/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.3/gbk_linux_amd64"
      sha256 "dd52cc2d8e9d96d840f977773b77317da9cb1553cb1ed57bbef0645273807e80"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.3/gbk_linux_arm64"
      sha256 "e2edc20c632fe3043a067233b459ee2637f56e028524ba65c7236efc8086102f"
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
