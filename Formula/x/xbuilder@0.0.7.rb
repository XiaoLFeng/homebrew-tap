# Formula for xbuilder@0.0.7
# 构建部署流水线 CLI 工具
class XbuilderAT007 < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.0.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.7/xbuilder-darwin-arm64"
      sha256 "69b6b04deb18f61fb07e62779db09f1aaa5b69ff905c7cd17028010bfc452571"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.7/xbuilder-darwin-amd64"
      sha256 "2dbf6a28173cd736623a259304b9a6cb5520cc535b045b283008de2c23cb0187"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.7/xbuilder-linux-arm64"
      sha256 "ca51b474e53ec956d953a73f23d0ba31dc04d4db607a01ef2aa03fb4535ac3b8"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.0.7/xbuilder-linux-amd64"
      sha256 "0059c3f895e6e2b2cedcce69716172731959959e0b2a660c8d0731426979ce3e"
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
