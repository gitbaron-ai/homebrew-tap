class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.0/gbk_darwin_amd64"
      sha256 "5ebcf2ce309a356d04bd7cf67c18810366d599331abf11067c3485fd96d15ba5"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.0/gbk_darwin_arm64"
      sha256 "d45cf06b9ef36a92e539ffbe74cfb4151b68458661b095af75ce6e399cc93d2e"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.1.0/gbk_linux_amd64"
      sha256 "ae0099d4ba057fc055e8d192767e0e64741d03b6cbe0337e62c8cd08a86f6900"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.1.0/gbk_linux_arm64"
      sha256 "915b85075390bbf32e8f4dd41590c50e43eb880905306a94fd90f826ad8f5130"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
