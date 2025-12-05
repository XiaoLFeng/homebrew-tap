# Formula for llm-memory - LLM统一记忆系统
#
# 项目地址：https://github.com/XiaoLFeng/llm-memory
# 维护者：筱锋 (xiao_lfeng)
# 创建日期：2025-12-05

class LlmMemory < Formula
  desc "LLM-Memory - 大模型统一记忆系统"
  homepage "https://github.com/XiaoLFeng/llm-memory"
  version "0.0.2"
  license "Apache-2.0"

  # 明确声明仅支持 macOS
  depends_on :macos

  # macOS 平台配置
  on_macos do
    # 检查 CPU 架构
    if Hardware::CPU.arm?
      # Apple Silicon (M1/M2/M3/M4) 支持
      url "https://github.com/XiaoLFeng/llm-memory/releases/download/v#{version}/llm-memory-darwin-arm64"
      sha256 "a181b516424f0a54da8eb49039011a7eac2b6cc30355e1eaa5892d5595f60c49"
    else
      # Intel Mac 暂不支持
      odie <<~EOS
        ⚠️  llm-memory 当前版本仅支持 Apple Silicon (ARM64) Mac

        你的 Mac 使用的是 Intel 处理器，暂不支持。

        Intel 版本正在开发中，请关注项目更新：
        https://github.com/XiaoLFeng/llm-memory/releases

        或在 Issue 中反馈你的需求：
        https://github.com/XiaoLFeng/llm-memory/issues
      EOS
    end
  end

  def install
    # 注意：下载的是单个二进制文件（非压缩包）
    # 将 llm-memory-darwin-arm64 重命名为 llm-memory 并安装到 bin 目录
    bin.install "llm-memory-darwin-arm64" => "llm-memory"

    # 确保二进制文件有执行权限（通常 Homebrew 会自动处理）
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
        - macOS（仅支持 Apple Silicon）
        - 预编译二进制已包含所有依赖

      💡 提示：
        如果 macOS 阻止运行，请执行：
          xattr -d com.apple.quarantine $(which llm-memory)
    EOS
  end

  test do
    # 测试 1：验证版本号输出
    # 支持 "v0.0.2" 或 "0.0.2" 格式
    version_output = shell_output("#{bin}/llm-memory --version 2>&1", 0)
    assert_match "0.0.2", version_output

    # 测试 2：验证帮助命令
    # 确保基本命令能正常运行
    system "#{bin}/llm-memory", "--help"

    # 测试 3：验证文件存在且可执行
    assert_predicate bin/"llm-memory", :exist?
    assert_predicate bin/"llm-memory", :executable?
  end
end
