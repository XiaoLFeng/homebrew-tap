# Formula for xbuilder
# 构建部署流水线 CLI 工具
class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.4/xbuilder-darwin-arm64"
      sha256 "c38902e3a0a273e0a149d5fe86f0408baefd568c58c4cc6d350e96f66581eb25"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.4/xbuilder-darwin-amd64"
      sha256 "b67bd9cfa2082ed29237725d782d33382c6d76dc392770b23e6a0380f47a0350"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.4/xbuilder-linux-arm64"
      sha256 "6afb381a6a9b69bff77eff0f8352e138ecb5c173b28a9dd2f182a5f9691586a3"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.4/xbuilder-linux-amd64"
      sha256 "2dbc8ede30af17714b83cbf009dae1a76acb004d8a438fd5bf2db7b3845c5a3f"
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
