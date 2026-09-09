class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.12"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.12/gbk_darwin_amd64"
      sha256 "ebf4d45a88254897d124aa71c1fbceeb25963bacb319416fc46e238b1e4c9de6"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.12/gbk_darwin_arm64"
      sha256 "97646e5eb93c49cc18bfdb728988bd308cc560477c6bd79a5382a30cec5ad8ca"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.12/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.12/gbk_linux_amd64"
      sha256 "69329c74b6a758dc079b2932d5f142a9777afb3c583ff88a9b16d1c21d5f1f89"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.12/gbk_linux_arm64"
      sha256 "ee208017abc05cc4b20ea327df1c1f20eed0f6abda8002b8f6b150e206001a73"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
    if OS.mac? && Hardware::CPU.arm?
      resource("gbk-applellm").stage do
        bin.install "gbk-applellm_darwin_arm64" => "gbk-applellm"
      end
      chmod 0755, bin/"gbk-applellm"
    end
  end

  def post_install
    # brew upgrade deletes the old Cellar inode; re-register MCP commands
    ohai "Refreshing GitBaron MCP registration (gbk install)"
    system bin/"gbk", "install" or true
  rescue
    true
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
