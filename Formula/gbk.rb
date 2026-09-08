class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.8"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.8/gbk_darwin_amd64"
      sha256 "a479a9b90df929bd08f6259370d02664ef56d002cdf57dda49b357f9902c1172"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.8/gbk_darwin_arm64"
      sha256 "0905e5906abe9923e70c80e6b44a518e397800828de278798057593569791f1a"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.8/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.8/gbk_linux_amd64"
      sha256 "1da7a85a1f3970997e850b550e5ce71e9679e70cf549f756bf5587efaa92a888"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.8/gbk_linux_arm64"
      sha256 "701fc07798d78fdc7995f3b8340b26cc7745aa9942fa3b2db2e600da10b303f5"
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
