class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.3.1/gbk_darwin_amd64"
      sha256 "4dbca827362f801e76199cb308a37d6af3f11376b379b552a5929cc6445100d7"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.3.1/gbk_darwin_arm64"
      sha256 "fa04e9661ee98b6bdf637bca724b7846d688642b5130cba7589f2bf82e51d948"
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.3.1/gbk_linux_amd64"
      sha256 "208ca667e013c6ff0d71bb2a78b6c6ee167bab3436b4e82cd379fafce6a761a1"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.3.1/gbk_linux_arm64"
      sha256 "30ee48ef5eea3299ac85f6a62a2c39eeb0eb72f6ab244e4a05edff4e4421cbb7"
    end
  end

  def install
    bin.install stable.url.split("/").last => "gbk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gbk version")
  end
end
