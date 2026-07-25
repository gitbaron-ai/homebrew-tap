class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.2.2/gbk_darwin_amd64"
      sha256 "8a3167eddbc34a4bc9b7372a03386d8dbf5f9b43f230c382ae44435abba6eef1"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.2.2/gbk_darwin_arm64"
      sha256 "3430fafcd87f375de2b0df8402720b2610a38cb3aa7962da9b01f3c9d07126ca"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.2.2/gbk_linux_amd64"
      sha256 "e0d18863958926741fe3ae8f74b4f54f845071495c806931658c50ce69c27803"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.2.2/gbk_linux_arm64"
      sha256 "5a1687b95c54cb738d1f32c440d9491b78e0327d474bc963b5891b5070118d14"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
