class Memoria < Formula
  desc "Simple memory for AI agents"
  homepage "https://github.com/bleep-talk/memoria"
  version "0.1.0"
  license "MIT"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/bleep-talk/memoria/releases/download/v0.1.0/memoria-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "ad67facb388de4c0982e6679604c64b43676cc0c7a7280a2f5cd7e13964630a8"
    end
    on_intel do
      url "https://github.com/bleep-talk/memoria/releases/download/v0.1.0/memoria-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "e62bb516e396696c4788ca23919616de2fd9ad9e580e422a1d909ab61a0452f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bleep-talk/memoria/releases/download/v0.1.0/memoria-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5704a3067f55a22ac110adee14136312864c5f798fdb4f3f92306e39cc49442"
    end
    on_intel do
      url "https://github.com/bleep-talk/memoria/releases/download/v0.1.0/memoria-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d6970d014a353304a11adfb797d21c293a1005d36736ff96e9758c3d3bd8fe4"
    end
  end

  def install
    bin.install "bin/memoria"
    (share/"memoria").install "share/memoria/skill"
    doc.install "README.md", "LICENSE", "docs", "THIRD_PARTY_LICENSES"
    inreplace doc/"README.md", "(share/memoria/skill/SKILL.md)", "(../../memoria/skill/SKILL.md)"
  end

  test do
    system bin/"memoria", "init", testpath/"memory"
    output = shell_output("#{bin}/memoria --repo #{testpath}/memory --json context")
    assert_equal 1, JSON.parse(output).fetch("schema_version")
    assert_path_exists share/"memoria/skill/SKILL.md"
  end
end
