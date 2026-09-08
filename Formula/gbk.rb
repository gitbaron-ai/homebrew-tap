class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.7"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.7/gbk_darwin_amd64"
      sha256 "fd129513235b6633bf7ffcd8fd5f01d224f2d9842c80216262a8340fddf40ad3"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.7/gbk_darwin_arm64"
      sha256 "0bc29c7675c2e34d801041a7d457c0565fefe8c3dc6204b06b05bff1777e5c3b"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.7/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.7/gbk_linux_amd64"
      sha256 "1077fc094fd0df6d95e3cbcdf928936b545fd25ae869c26d6d83d0e63bdf499e"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.7/gbk_linux_arm64"
      sha256 "a82b5e955a9c4bdf5337faa3f82ce67d0dececa7fb5ae7f23b4bc3f6c18f0fe8"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
