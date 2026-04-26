class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.6"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.6/gbk_darwin_amd64"
      sha256 "2cc5608cc5059432324b9ccf738036268a83bfab32ad5ffb29ef16855cba67b0"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.6/gbk_darwin_arm64"
      sha256 "383449f308e0428cc5cf2254d40957155b894f15eeced74df2810a0ae3f9623a"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.6/gbk_linux_amd64"
      sha256 "41755a7ca3674e13b930500ec602e07176f547d0690a8f64e7cb532cfacbbb3e"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.6/gbk_linux_arm64"
      sha256 "a5a677976e2de26633d5d83e974d0c6a510fa76ebf3416910525deea3c75db86"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
