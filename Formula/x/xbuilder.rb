# Formula for xbuilder
# 构建部署流水线 CLI 工具
class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.5/xbuilder-darwin-arm64"
      sha256 "112abb5d212566a8fb08b5f1010902d512751abe40f96a85f72819ff2ee75a11"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.5/xbuilder-darwin-amd64"
      sha256 "6e9f5305cc5f97cd1e7f275a21e4d679fd816844b8c8fa83d8ba25041c530793"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.5/xbuilder-linux-arm64"
      sha256 "2a4b9f05f79575f25600f2a49c8c564cd3efd6529606e18ed452a62fd1226e71"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.5/xbuilder-linux-amd64"
      sha256 "8b8f73c38b3dc81f04024c025d86e28eaae82e3c907afa211fe3592ab30480dd"
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
