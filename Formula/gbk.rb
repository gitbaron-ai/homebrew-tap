class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.5/gbk_darwin_amd64"
      sha256 "4ac9ff1a3b0e656199c5c4a75bb3483181bd7757cfe42cfeb848a342f86453c7"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.5/gbk_darwin_arm64"
      sha256 "9b7ff720a1fd4425bca0429b902b6819563cfa408ca68634033be35f7686cd13"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.5/gbk_linux_amd64"
      sha256 "8448966003992cedcdcffecd22f6dc4eae6141d8239b89d6b1b5f1dc37b11cec"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.5/gbk_linux_arm64"
      sha256 "6b57b540ef36d5c633bacf89aea73145996f4f734ae1fb34628334a626d2efe6"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
