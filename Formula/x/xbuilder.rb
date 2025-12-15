# Formula for xbuilder
# 构建部署流水线 CLI 工具
class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.3/xbuilder-darwin-arm64"
      sha256 "1963d4ac5425a07ff83081c866b68531503b3d430398de0e3911751c987044a7"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.3/xbuilder-darwin-amd64"
      sha256 "2949c156b1eaf9ca7286b09ade388f09f6dfc32c86760a84699e541e7bcaec9e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.3/xbuilder-linux-arm64"
      sha256 "6220a8775e87d66f9611f49e456f3cb0b1192b52ade121d66e983ae74ecaf0de"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.3/xbuilder-linux-amd64"
      sha256 "9e1dbf80989962c3519a007f1863a9a3a2124223c04eb466c34633aa449663b3"
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
