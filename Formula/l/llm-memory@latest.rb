# Formula for llm-memory@latest - LLM统一记忆系统（最新版本）
#
# 项目地址：https://github.com/XiaoLFeng/llm-memory
# 维护者：筱锋 (xiao_lfeng)
# 创建日期：2025-12-05

class LlmMemoryATLatest < Formula
  desc "大模型统一记忆系统"
  homepage "https://github.com/XiaoLFeng/llm-memory"
  version "0.0.3"
  license "Apache-2.0"

  # 支持 macOS 和 Linux
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/llm-memory/releases/download/v#{version}/llm-memory-darwin-arm64"
      sha256 "a181b516424f0a54da8eb49039011a7eac2b6cc30355e1eaa5892d5595f60c49"
    else
      url "https://github.com/XiaoLFeng/llm-memory/releases/download/v#{version}/llm-memory-darwin-amd64"
      sha256 "PLACEHOLDER_DARWIN_AMD64_SHA256"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/XiaoLFeng/llm-memory/releases/download/v#{version}/llm-memory-linux-arm64"
      sha256 "PLACEHOLDER_LINUX_ARM64_SHA256"
    else
      url "https://github.com/XiaoLFeng/llm-memory/releases/download/v#{version}/llm-memory-linux-amd64"
      sha256 "PLACEHOLDER_LINUX_AMD64_SHA256"
    end
  end

  def install
    # 根据操作系统和架构安装对应的二进制文件
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "llm-memory-darwin-arm64" => "llm-memory"
      else
        bin.install "llm-memory-darwin-amd64" => "llm-memory"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "llm-memory-linux-arm64" => "llm-memory"
      else
        bin.install "llm-memory-linux-amd64" => "llm-memory"
      end
    end

    # 确保二进制文件有执行权限
    chmod 0755, bin/"llm-memory"
  end

  def caveats
    <<~EOS
      🎉 llm-memory 已成功安装！

      快速开始：
        # 查看版本
        llm-memory --version

        # 查看帮助
        llm-memory --help

      📝 使用说明：
        - 数据存储位置：~/.llm-memory/
        - 使用 SQLite 作为本地数据库
        - 支持作为 MCP (Model Context Protocol) 服务器运行

      📚 更多信息：
        - 项目主页：https://github.com/XiaoLFeng/llm-memory
        - 文档：https://github.com/XiaoLFeng/llm-memory#readme
        - 问题反馈：https://github.com/XiaoLFeng/llm-memory/issues

      ⚙️  系统要求：
        - macOS (Apple Silicon & Intel) 或 Linux (amd64 & arm64)
        - 纯 Go 编译，无需额外依赖

      💡 提示：
        如果 macOS 阻止运行，请执行：
          xattr -d com.apple.quarantine $(which llm-memory)
    EOS
  end

  test do
    # 测试 1：验证版本号输出
    # 支持 "v0.0.3" 或 "0.0.3" 格式
    version_output = shell_output("#{bin}/llm-memory --version 2>&1")
    assert_match version.to_s, version_output

    # 测试 2：验证帮助命令
    # 确保基本命令能正常运行
    system bin/"llm-memory", "--help"

    # 测试 3：验证文件存在且可执行
    assert_path_exists bin/"llm-memory"
  end
end
