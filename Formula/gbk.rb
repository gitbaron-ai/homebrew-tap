class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.3/gbk_darwin_amd64"
      sha256 "5094235434917d7108b63662b836e0bf73c51a2c3349c8676d2f9d752df924de"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.3/gbk_darwin_arm64"
      sha256 "926bba015266aff2d56e4678a0635d96caf058b444aaf3296b29d5edb1ced7e6"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.3/gbk_linux_amd64"
      sha256 "86c8b60ce0a2c4993fe4cc895289b340a6950fc2ccc004f9fa794290f58e092b"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.3/gbk_linux_arm64"
      sha256 "bd5b5bf87b698a375dbc465a024f0f3b2d85c18a96a4ce55a6da883a4467ff5a"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
