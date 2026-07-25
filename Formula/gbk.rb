class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.2.3/gbk_darwin_amd64"
      sha256 "8057526188764a9c6ebf5ddcebb38f6cad8f479573e0ca23224fe77be2a982a4"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.2.3/gbk_darwin_arm64"
      sha256 "e403554f786ecc591fcb6492997337f15df405736a70c4ab37207e138c736c31"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.2.3/gbk_linux_amd64"
      sha256 "195e9b41428e278c8268e5049b5b4ef6b60942a0c2a086590118cf27e6afb3af"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.2.3/gbk_linux_arm64"
      sha256 "c13dc2013c65bce13eef5d816004fa3281f9f40a95aa5a1cf1fd91f793373d6a"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
