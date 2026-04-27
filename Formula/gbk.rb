class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.8/gbk_darwin_amd64"
      sha256 "2b1398b80169c8425ea494b8040ce0ce3e56017c932d9c121531b21af5e93e7b"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.8/gbk_darwin_arm64"
      sha256 "6f79c6aa5a2358f61530ca9c67ec59a8b096af8695510d40e6a64ab57978d1c1"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.8/gbk_linux_amd64"
      sha256 "78995d49b44691ddc12da6f99b7957714e8486d2a4d5f026b353984d72d263e6"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.8/gbk_linux_arm64"
      sha256 "62d1355d449ee9342d3720855e450517af4909c7d1e3d06128be81d1651ac581"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
