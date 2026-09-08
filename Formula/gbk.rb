class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.5/gbk_darwin_amd64"
      sha256 "9580f19ec4a7b04c323280342caa0150aa0142a1d397f2d1b6417f95dd2d6d08"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.5/gbk_darwin_arm64"
      sha256 "96928aa4c67b6e277ed42382d142070b55fccbe17ed43d56545e931fd0fa6e31"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.5/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.5/gbk_linux_amd64"
      sha256 "2212d6b7f737eb2e94ae5766ecba34225330cb2be7172c942fc8a37be7f43165"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.5/gbk_linux_arm64"
      sha256 "77e119a5921ca35460eb82871a51f85d1b68be622888c6cd9f5f0e79cefa5b26"
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
