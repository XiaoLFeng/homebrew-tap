class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.1/xbuilder-darwin-arm64"
      sha256 "43f22b8a4acf5a804e327adda4c427dc47c77804db17cfed1aa94ba4a4690cab"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.1/xbuilder-darwin-amd64"
      sha256 "ce93bbdfafcef06531a3e5342afdfb922fe9cdb0168d2e514d3ad915320ddc48"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.1/xbuilder-linux-arm64"
      sha256 "7e2537aef26d906cb996f6fef04488c8805a49a97c95ade5546990c0e7375ce1"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.1/xbuilder-linux-amd64"
      sha256 "0a6ec43df7021382dbeed235bd8a29e7d90cab721ded9e5c7b861d7fa4855447"
    end
  end

  def install
    binary_name = "xbuilder"
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "xbuilder-darwin-arm64" => binary_name
      else
        bin.install "xbuilder-darwin-amd64" => binary_name
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "xbuilder-linux-arm64" => binary_name
      else
        bin.install "xbuilder-linux-amd64" => binary_name
      end
    end
  end

  test do
    system "#{bin}/xbuilder", "--version"
  end
end
