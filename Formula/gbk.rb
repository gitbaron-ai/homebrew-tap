class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.5.0/gbk_darwin_amd64"
      sha256 "b393f3f3c83179eb88fb2aef656e86506cf30b8aeedb4662046e4c723a903249"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.5.0/gbk_darwin_arm64"
      sha256 "c0bccda389fdcc2dbf96923324efd492e8c639d8089a938cff524cee4d9c6d92"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.5.0/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.5.0/gbk_linux_amd64"
      sha256 "55b7efdc970a244def0b50ddb7de7f6e86d5c5ef3d67f8752b69389571d526fa"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.5.0/gbk_linux_arm64"
      sha256 "e22e7d9f742053cd82111e4fc37cf4d04edb67298a48add6f4dc0d5c77841dfa"
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
