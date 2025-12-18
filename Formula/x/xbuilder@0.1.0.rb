# Formula for xbuilder@0.1.0
# 构建部署流水线 CLI 工具
class XbuilderAT010 < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.0/xbuilder-darwin-arm64"
      sha256 "45697b01e25f732ff114b262f9751247d9fdc7a394906d3d7f998b15529d83d1"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.0/xbuilder-darwin-amd64"
      sha256 "f88874c8cedfcf75320bb9e0296ef1809d1e9fd1bd23e40d341fa119de407c7d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.0/xbuilder-linux-arm64"
      sha256 "418e5b3698557261dedcb7aca1e701903b4bb39b97a7189c83035e75dd1d523e"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.0/xbuilder-linux-amd64"
      sha256 "cdeafea560fad1a5f17285325131f132928b010b6a02424ba11c95e8f9481322"
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
