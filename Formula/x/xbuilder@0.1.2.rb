# Formula for xbuilder@0.1.2
# 构建部署流水线 CLI 工具
class XbuilderAT012 < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.2/xbuilder-darwin-arm64"
      sha256 "fa6267152c01596f376e1630e21ee8b5d4ffcff05f8e74430665ba4133582cff"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.2/xbuilder-darwin-amd64"
      sha256 "b1aec17596e63797fd626061874a333a2d0252289e4ac5f3c52198dbb7ddbcf8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.2/xbuilder-linux-arm64"
      sha256 "9e9495ed9aabf69b998423cf6ae9cc993ffc97ceefc6139108b149d43457f926"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.2/xbuilder-linux-amd64"
      sha256 "8999c723fbbc1e1b61b111b11e5ae2897b1d2e2b4c1e049119846e03f979a5bf"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "xbuilder-darwin-arm64" => "xbuilder"
      else
        bin.install "xbuilder-darwin-amd64" => "xbuilder"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "xbuilder-linux-arm64" => "xbuilder"
      else
        bin.install "xbuilder-linux-amd64" => "xbuilder"
      end
    end
  end

  def caveats
    <<~
      ⚠️  注意：这是一个固定版本的 Formula
      - 此版本不会自动更新到更高版本
      - 如需最新版本，请使用：brew install xbuilder
    EOS
      🎉 xbuilder 已成功安装！

      快速开始：
        xbuilder --help     # 查看帮助
        xbuilder init       # 初始化配置
        xbuilder run        # 运行构建

      文档：https://github.com/XiaoLFeng/builder-cli
    
      ⚠️  注意：这是一个固定版本的 Formula
      - 此版本不会自动更新到更高版本
      - 如需最新版本，请使用：brew install xbuilder
    EOS
  end

  test do
    system "#{bin}/xbuilder", "--version"
  end
end
