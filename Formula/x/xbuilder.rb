# Formula for xbuilder
# 构建部署流水线 CLI 工具
class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.4/xbuilder-darwin-arm64"
      sha256 "2a7813d6a5a482207b0bfa3723a87fc15c29ee0adb75e4427b33b471ac842c93"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.4/xbuilder-darwin-amd64"
      sha256 "0dfe6ee3f7b7d28d0a792d9adff3b813e50152fab4c00d1ea9977e1919ad907a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.4/xbuilder-linux-arm64"
      sha256 "0a47b4ff9298e266940346966ce6a7c59ce64ff20f5cd6d25f096bf6de98a707"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.4/xbuilder-linux-amd64"
      sha256 "12b586ee5142d9f1122a21942513f9c6c5d2fb2c216f2e4ba8b83ff2b1e907d6"
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
    <<~EOS
      🎉 xbuilder 已成功安装！

      快速开始：
        xbuilder --help     # 查看帮助
        xbuilder init       # 初始化配置
        xbuilder run        # 运行构建

      文档：https://github.com/XiaoLFeng/builder-cli
    EOS
  end

  test do
    system "#{bin}/xbuilder", "--version"
  end
end
