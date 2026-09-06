class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.1/gbk_darwin_amd64"
      sha256 "e26a807572ed368a6c3f7276d50596d69ef3a007aa659a395bfc8532649d0a96"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.1/gbk_darwin_arm64"
      sha256 "1727e973c216ea9ac137432a8e2624fdaf74679b8bf264f75df44db8ca811696"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.1/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.1/gbk_linux_amd64"
      sha256 "75eca7516c8d81bbc8fd268e17e221047a412179939f4eb56382ac59724e6ac5"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.1/gbk_linux_arm64"
      sha256 "2cd2f48daaf474850e733add285476b208881b063a5066824df44ff59c630d47"
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
