# Formula for xbuilder
# 构建部署流水线 CLI 工具
class Xbuilder < Formula
  desc "CLI tool for building and deploying applications with pipeline support"
  homepage "https://github.com/XiaoLFeng/builder-cli"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.1/xbuilder-darwin-arm64"
      sha256 "5bfda793dd87edcb0ec0756b30e8516f121c0323204585c062641e8844583135"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.1/xbuilder-darwin-amd64"
      sha256 "70d9c918de551c491a23e1f7f5c93da0ca08a503cb364b56bb5a7bd437c863ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.1/xbuilder-linux-arm64"
      sha256 "93e5133f7025cf2207beb490f4cc3c070a5f446639ef6f1b7416b3a8c87b0d5f"
    else
      url "https://github.com/XiaoLFeng/builder-cli/releases/download/v0.1.1/xbuilder-linux-amd64"
      sha256 "2534edc15c879be31e5dda681afad89cee3d02d49f66f25a12165749928b65d4"
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
