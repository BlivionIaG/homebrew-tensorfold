# Unofficial repackaging of the ashhart/TensorFold macOS release; bottles are built and published by this tap's CI.
class Tensorfold < Formula
  desc "Native TensorFold inference server for Apple Silicon"
  homepage "https://github.com/ashhart/TensorFold"
  url "https://github.com/ashhart/TensorFold/releases/download/v1.1.0/tensorfold-1.1.0-macos-arm64.tar.gz"
  sha256 "99c66f56fcde07a7dd8df6ea555bcbd406d0537b7d92a453112a54bef5a72707"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/blivioniag/tensorfold"
    sha256 cellar: :any, arm64_tahoe: "32fb9aa6a836fe9fc08b3c28fc82279b5700fc2009dd625689afa1d5207a09c8"
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/tensorfold-native" => "tensorfold-native"
    bin.install_symlink libexec/"bin/tensorfold-native" => "tensorfold"
  end

  def caveats
    <<~EOS
      Download a model, then serve it:
        tensorfold pull TensorFold/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-MLX-4bit
        tensorfold serve TensorFold/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-MLX-4bit
    EOS
  end

  test do
    assert_equal "tensorfold-native #{version}", shell_output("#{bin}/tensorfold-native --version").strip
    assert_match "serve MODEL", shell_output("#{bin}/tensorfold --help")
    assert_path_exists libexec/"lib/libtfgrammar.dylib"
  end
end
