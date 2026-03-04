# Formula for bamboo-document@0.1.1 - Bamboo 竹简库文档 MCP 服务（固定版本）
#
# 项目地址：https://github.com/bamboo-services/bamboo-document-mcp
# 维护者：筱锋 (xiao_lfeng)
# 创建日期：2026-03-04

class BambooDocumentAT011 < Formula
  desc "Bamboo 竹简库文档 MCP 服务 - 从 doc.x-lf.com 获取文档信息"
  homepage "https://github.com/bamboo-services/bamboo-document-mcp"
  version "0.1.1"
  license "MIT"

  # 支持 macOS 和 Linux
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bamboo-services/bamboo-document-mcp/releases/download/v#{version}/bamboo-document-darwin-arm64"
    else
      url "https://github.com/bamboo-services/bamboo-document-mcp/releases/download/v#{version}/bamboo-document-darwin-amd64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bamboo-services/bamboo-document-mcp/releases/download/v#{version}/bamboo-document-linux-arm64"
    else
      url "https://github.com/bamboo-services/bamboo-document-mcp/releases/download/v#{version}/bamboo-document-linux-amd64"
    end
  end

  def install
    # 根据操作系统和架构安装对应的二进制文件
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "bamboo-document-darwin-arm64" => "bamboo-document"
      else
        bin.install "bamboo-document-darwin-amd64" => "bamboo-document"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "bamboo-document-linux-arm64" => "bamboo-document"
      else
        bin.install "bamboo-document-linux-amd64" => "bamboo-document"
      end
    end

    # 确保二进制文件有执行权限
    chmod 0755, bin/"bamboo-document"
  end

  def caveats
    <<~EOS
      🎉 bamboo-document@0.1.1 已成功安装！

      ⚠️  注意：这是一个固定版本的 Formula
      - 此版本不会自动更新到更高版本
      - 如需最新版本，请使用：brew install bamboo-document

      快速开始：
        # 验证安装
        bamboo-document --help

      📝 使用说明：
        - 这是一个 MCP (Model Context Protocol) 服务器
        - 用于从 doc.x-lf.com 获取 Bamboo 文档信息
        - 支持文档目录列表、文档详情获取和搜索功能

      📚 更多信息：
        - 文档站点：https://doc.x-lf.com
        - 项目主页：https://github.com/bamboo-services/bamboo-document-mcp
        - 问题反馈：https://github.com/bamboo-services/bamboo-document-mcp/issues

      ⚙️  系统要求：
        - macOS (Apple Silicon & Intel) 或 Linux (amd64 & arm64)
        - 纯 Go 编译，无需额外依赖

      💡 提示：
        如果 macOS 阻止运行，请执行：
          xattr -d com.apple.quarantine $(which bamboo-document)
    EOS
  end

  test do
    # 测试 1：验证文件存在且可执行
    assert_path_exists bin/"bamboo-document"

    # 测试 2：验证二进制文件可以运行
    # 由于是 MCP 服务器，主要通过 stdio 通信，验证帮助命令即可
    system bin/"bamboo-document", "--help"
  end
end
