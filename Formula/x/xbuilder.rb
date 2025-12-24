# Formula for xbuilder
# 构建部署流水线 CLI 工具
class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.3/xbuilder-darwin-arm64"
      sha256 "f7c31d4a89368eaf6cce3c578693b5df498a9e37b63ebebf0914171a8f339992"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.3/xbuilder-darwin-amd64"
      sha256 "791f5aa72dd0646c404321c647c6a357c8a7fe43b9c08bdfc508da3701dac9d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.3/xbuilder-linux-arm64"
      sha256 "b3db119b1d164fd7b5e5c732bd3294466b637728df40db33c144137ed007cbf4"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.3/xbuilder-linux-amd64"
      sha256 "477243b36ee28b3378584ee33be200eb4caf1d29c49820ccfb2db6a944c4ce94"
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
