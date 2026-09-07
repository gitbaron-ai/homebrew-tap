class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.2/gbk_darwin_amd64"
      sha256 "596965fba02938e10572ab91e90826231f5b018debfbd101b426011d75f70df2"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.2/gbk_darwin_arm64"
      sha256 "4e2c73b7eecd1ee4f1a7d2232d6146e1b3f72cb0ad3050e7763e0838340d5ac3"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.2/gbk-applellm_darwin_arm64"
        sha256 "4dacf0d560ad42907903bd021709cd793d2833ad12edb613d3971a89dc285668"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.2/gbk_linux_amd64"
      sha256 "e699e4dbc9e5c147c69bb3927fd4989e37d7b5ef55fe66f7f6631037a80989e5"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.2/gbk_linux_arm64"
      sha256 "6eb2967f221e942092cc3acd60441aada6d4c5023f8967d3aca3747bf79a3c2f"
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
