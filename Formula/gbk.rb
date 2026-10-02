class Gbk < Formula
  desc "GitBaron CLI — wire up Claude Code with GitBaron intelligence"
  homepage "https://gitbaron.ai"
  version "0.7.16"
  license "MIT"

  on_macos do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.16/gbk_darwin_amd64"
      sha256 "46b93e928ab063d008fca900324e44b7129336795b4cfc706e1403d9c66e021b"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.16/gbk_darwin_arm64"
      sha256 "b158f169e59998fac22315ee14c2810505f3b8223364d7068b6c7b3174cdb5b1"
      resource "gbk-applellm" do
        url "https://dl.gitbaron.ai/gbk/v0.7.16/gbk-applellm_darwin_arm64"
        sha256 "903a94191823c298f6bf71cdd47d9656eceae574dc192d15942b856550d8af2f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://dl.gitbaron.ai/gbk/v0.7.16/gbk_linux_amd64"
      sha256 "05533d48747c4659708b24db7fc6ffd440bd2688a2b89d122734a2152d38b875"
    end
    on_arm do
      url "https://dl.gitbaron.ai/gbk/v0.7.16/gbk_linux_arm64"
      sha256 "ee464e17f953da3cf52eb25888f06d715a34761ca353c584838f95ad584d9d37"
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
