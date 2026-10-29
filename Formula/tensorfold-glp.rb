# Unofficial repackaging of the BlivionIaG/TensorFold GLP build (upstream main plus native control-vector steering).
class TensorfoldGlp < Formula
  desc "TensorFold native engine with native control-vector (GLP) steering"
  homepage "https://github.com/BlivionIaG/TensorFold"
  url "https://github.com/BlivionIaG/TensorFold/releases/download/v1.1.8-glp.1/tensorfold-1.1.8-macos-arm64.tar.gz"
  version "1.1.8"
  sha256 "2b85b281d88ee01a26da81b795b995ecaa264823b00250ee286f9a78f54808d4"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    libexec.install Dir["*"]
    # Its own name, so this keg and the plain tensorfold keg can sit side by side.
    mv libexec/"bin/tensorfold-native", libexec/"bin/tensorfold-glp-native"
    bin.install_symlink libexec/"bin/tensorfold-glp-native" => "tensorfold-glp-native"
    bin.install_symlink libexec/"bin/tensorfold-glp-native" => "tensorfold-glp"
  end

  def caveats
    <<~EOS
      Download a model, then serve it:
        tensorfold-glp pull TensorFold/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-MLX-4bit
        tensorfold-glp serve TensorFold/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-MLX-4bit

      Steer the served model with a control vector:
        tensorfold-glp serve MODEL --glp control.gglp --glp-alpha 1.0

      This is the GLP build: upstream's engine plus native control-vector steering.
      The plain engine is the tensorfold formula.
    EOS
  end

  test do
    assert_equal "tensorfold-native #{version}", shell_output("#{bin}/tensorfold-glp-native --version").strip
    assert_match "serve MODEL", shell_output("#{bin}/tensorfold-glp --help")
    assert_match "--glp FILE", shell_output("#{bin}/tensorfold-glp --help")
    assert_path_exists libexec/"lib/libtfgrammar.dylib"
  end
end
