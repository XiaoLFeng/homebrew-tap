# Formula for xbuilder
# 构建部署流水线 CLI 工具
class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.0.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.6/xbuilder-darwin-arm64"
      sha256 "8784261d019e2a727d126436fc666017ee474415f75227f837ad7692a87c752f"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.6/xbuilder-darwin-amd64"
      sha256 "1fa17a6f86c2bd0c2a4f6ef49874501af849dc93f136b7d8fea24e6018df5788"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.6/xbuilder-linux-arm64"
      sha256 "d108b933bff9146aca852613df952cb62fb22b3d9f7678ff3c5c4b3bfd7b6072"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.6/xbuilder-linux-amd64"
      sha256 "b36180843075e6a8c158fc5bfef3f2c37fdaead5ca80dcc51375f593732596b7"
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
