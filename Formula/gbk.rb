class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.4/gbk_darwin_amd64"
      sha256 "c5df8ed97d9d6cc1923d3ba8dd63697c46f43d68d845d40f569b46cc9666ff33"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.4/gbk_darwin_arm64"
      sha256 "bc690fd29ab01632b7468933e8e51bb4787079aac1113f01a021df473c86a363"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.4/gbk_linux_amd64"
      sha256 "4868ed6d322b8c9739ba28104d67d0865d748800b79f4490f86ff01c81db9fcf"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.4/gbk_linux_arm64"
      sha256 "792970a6f75293c8d08366f2334b50a1b92179e8c1ec65ff72fb324a7b754f53"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
