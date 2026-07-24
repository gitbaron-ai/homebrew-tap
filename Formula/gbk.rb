class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.2.1/gbk_darwin_amd64"
      sha256 "8a527d4bc9cdf2fd153385dac27db529584796e3adfd63862d94a9a66005ee0f"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.2.1/gbk_darwin_arm64"
      sha256 "1a8ee63db2bc62b3ba0e7b03a98bbc9bb1864ae135b7cf05e1d0a8b15c931717"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.2.1/gbk_linux_amd64"
      sha256 "3719f883ad1a9ad076a3390ccb432b9bf1c5d32200880488bccc357547ad800d"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.2.1/gbk_linux_arm64"
      sha256 "bd81923383cd2252b93cc8f4e9ea888d2378d019c708a318ec9786f16d59dd3f"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
