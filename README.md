# Homebrew Tap - 筱锋的自定义软件源

欢迎来到筱锋的 Homebrew Tap 仓库！这里包含了我个人维护的 Homebrew Formula 集合，主要用于分发命令行工具。

## 什么是 Homebrew Tap？

Homebrew Tap 是 Homebrew 的第三方软件源，允许你安装官方仓库之外的软件包。通过添加这个 Tap，你可以轻松安装和管理这里托管的所有工具。

## 快速开始

### 添加这个 Tap

```bash
brew tap xiao_lfeng/tap
```

> **注意**：请将 `xiao_lfeng` 替换为你的 GitHub 用户名

### 安装 Formula

添加 Tap 后，你可以像安装其他 Homebrew 包一样安装这里的 Formula：

```bash
# 安装最新版本
brew install <formula-name>

# 安装特定版本（使用 @version 语法）
brew install <formula-name>@<version>
```

**示例**：
```bash
# 安装最新版本的 llm-memory
brew install llm-memory@latest

# 安装 llm-memory 0.0.2 版本
brew install llm-memory@0.0.2
```

### 更新 Formula

```bash
brew update
brew upgrade <formula-name>
```

### 卸载 Formula

```bash
brew uninstall <formula-name>
```

## 可用的 Formula

目前这个 Tap 中包含以下 Formula：

<!-- 在这里列出你的 Formula -->
| 名称 | 描述 | 最新版本 | 可用版本 | 平台支持 |
|------|------|----------|----------|----------|
| llm-memory | LLM-Memory - 大模型统一记忆系统 | 0.0.3 | 0.0.3 (latest), 0.0.2 | macOS (ARM64/Intel) & Linux (amd64/arm64) |

> 提示：当你添加新的 Formula 后，请更新这个列表！

## 目录结构

本 Tap 采用 Homebrew 官方推荐的**首字母分类法**组织 Formula：

```
Formula/
  l/
    llm-memory@latest.rb   # 最新版本（0.0.3）
    llm-memory@0.0.2.rb    # 固定版本 0.0.2
  # 未来的项目将按首字母分组
  # s/
  #   some-tool@latest.rb
  #   some-tool@1.0.0.rb
```

这样的组织方式有以下优点：
- ✅ 清晰的项目分组（按首字母）
- ✅ 版本化 Formula 集中管理
- ✅ 符合 Homebrew 官方规范
- ✅ 易于扩展和维护

## 如何编写 Formula？

如果你想为自己的项目创建 Formula，请参考 [Homebrew 官方文档](https://docs.brew.sh/Formula-Cookbook)

### 快速创建步骤

1. 在 `Formula/<首字母>/` 目录下创建 Formula 文件
   ```bash
   mkdir -p Formula/m
   touch Formula/m/my-app@latest.rb
   ```

2. 编辑 Formula 文件，填入你的项目信息：
   - 项目名称和描述
   - 下载 URL
   - SHA256 校验和
   - 安装逻辑

3. 测试 Formula
   ```bash
   brew install --build-from-source ./Formula/m/my-app@latest.rb
   brew test my-app@latest
   ```

4. 提交并推送到 GitHub

## 贡献指南

欢迎贡献！如果你发现问题或有改进建议：

1. Fork 这个仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

### Formula 命名规范

- **文件名**：使用小写字母和连字符，如 `my-app.rb`
- **类名**：使用驼峰命名法，如 `class MyApp < Formula`

### 测试要求

在提交 PR 前，请确保：

```bash
# 检查语法
brew audit --strict ./Formula/your-formula.rb

# 测试安装
brew install --build-from-source ./Formula/your-formula.rb

# 运行测试
brew test your-formula
```

## 常用命令

```bash
# 列出这个 Tap 中的所有 Formula
brew tap-info xiao_lfeng/tap

# 查看 Formula 信息
brew info <formula-name>

# 编辑 Formula（如果需要修改）
brew edit <formula-name>

# 移除这个 Tap
brew untap xiao_lfeng/tap
```

## 相关资源

- [Homebrew 官方文档](https://docs.brew.sh/)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew GitHub](https://github.com/Homebrew/brew)

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 联系方式

如有问题或建议，欢迎通过以下方式联系：

- GitHub Issues: [提交问题](../../issues)
- GitHub: [@xiao_lfeng](https://github.com/xiao_lfeng)

---

如果这个项目对你有帮助，欢迎给个 Star！

**由 筱锋 (xiao_lfeng) 用心维护**
