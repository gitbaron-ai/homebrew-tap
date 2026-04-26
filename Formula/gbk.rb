class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.2/gbk_darwin_amd64"
      sha256 "4ee891fddb7e3269a4bb447e86fc2259ed64e738b1fbf9ef708aa911f006820f"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.2/gbk_darwin_arm64"
      sha256 "d91c47180b1e4be9da4feca9da9c4ab90704110a26f40f446621ce5de68ea9aa"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.2/gbk_linux_amd64"
      sha256 "9da15253734fa0f4a9aff3f821464149ea4b7971d074b4d40c3485f475678ab8"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.2/gbk_linux_arm64"
      sha256 "d49d7e616cf9dae87403f057a6b6b9f634306da63471ff5cc6f8a4f95876ea0c"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
