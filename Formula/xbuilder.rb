class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.2/xbuilder-darwin-arm64"
      sha256 "4ad5f4e02bd3c59df68175db8a6cb02055e7fe9674a89c446b462ffce22b4e09"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.2/xbuilder-darwin-amd64"
      sha256 "e69f843926a3e77e58cb5ca39ebb83b5b7061b6dcf92f15a80e6d07d55f10061"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.2/xbuilder-linux-arm64"
      sha256 "23cf9ec7e239545557ab15d896a7db92ff08f887452f1dbfac191c22ffdfda85"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.2/xbuilder-linux-amd64"
      sha256 "1171659b045bbd47e57ed1cbc321be885affb5636858f9c49bcc6790fcbeddb8"
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
