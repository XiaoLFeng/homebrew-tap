# Formula for bamboo-base-cli - 筱工具(Golang) CLI
#
# 项目地址：https://github.com/bamboo-services/bamboo-base-go-cli
# 维护者：筱锋 (xiao_lfeng)
# 创建日期：2025-12-05

class BambooBaseCli < Formula
  desc "筱工具(Golang) 命令行工具"
  homepage "https://github.com/bamboo-services/bamboo-base-go-cli"
  version "0.1.0"
  license "Apache-2.0"

  # 支持 macOS 和 Linux
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bamboo-services/bamboo-base-go-cli/releases/download/v#{version}/bamboo-base-cli-darwin-arm64"
    else
      url "https://github.com/bamboo-services/bamboo-base-go-cli/releases/download/v#{version}/bamboo-base-cli-darwin-amd64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bamboo-services/bamboo-base-go-cli/releases/download/v#{version}/bamboo-base-cli-linux-arm64"
    else
      url "https://github.com/bamboo-services/bamboo-base-go-cli/releases/download/v#{version}/bamboo-base-cli-linux-amd64"
    end
  end

  def install
    # 根据操作系统和架构安装对应的二进制文件
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "bamboo-base-cli-darwin-arm64" => "bamboo-base-cli"
      else
        bin.install "bamboo-base-cli-darwin-amd64" => "bamboo-base-cli"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "bamboo-base-cli-linux-arm64" => "bamboo-base-cli"
      else
        bin.install "bamboo-base-cli-linux-amd64" => "bamboo-base-cli"
      end
    end

    # 确保二进制文件有执行权限
    chmod 0755, bin/"bamboo-base-cli"
  end

  def caveats
    <<~EOS
      🎉 bamboo-base-cli 已成功安装！

      快速开始：
        # 查看版本
        bamboo-base-cli --version

        # 查看帮助
        bamboo-base-cli --help

      📝 项目说明：
        - bamboo-base-cli 是筱工具(Golang) 相关的命令行工具
        - 详细能力与用法请参考官方文档

      📚 更多信息：
        - 项目主页：https://github.com/bamboo-services/bamboo-base-go-cli
        - 文档：https://doc.x-lf.com/docs/bamboo-base-go
        - 问题反馈：https://github.com/bamboo-services/bamboo-base-go-cli/issues

      ⚙️  系统要求：
        - macOS (Apple Silicon & Intel) 或 Linux (amd64 & arm64)
        - 纯 Go 编译，无需额外依赖

      💡 提示：
        如果 macOS 阻止运行，请执行：
          xattr -d com.apple.quarantine $(which bamboo-base-cli)
    EOS
  end

  test do
    # 测试 1：验证版本号输出
    # 支持 "v0.0.3" 或 "0.0.3" 格式
    version_output = shell_output("#{bin}/bamboo-base-cli --version 2>&1")
    assert_match version.to_s, version_output

    # 测试 2：验证帮助命令
    # 确保基本命令能正常运行
    system bin/"bamboo-base-cli", "--help"

    # 测试 3：验证文件存在且可执行
    assert_path_exists bin/"bamboo-base-cli"
  end
end
