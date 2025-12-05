# Homebrew Formula 编写完整指南 📚

欢迎来到 Homebrew Formula 编写指南！这份文档将帮助你从零开始创建自己的 Formula，并发布到这个 Tap 中。

## 📖 目录

- [什么是 Formula？](#什么是-formula)
- [命名规范](#命名规范)
- [Formula 基本结构](#formula-基本结构)
- [Ruby 下载定义的 4 种方式](#ruby-下载定义的-4-种方式)
- [版本号管理](#版本号管理)
- [SHA256 校验和计算](#sha256-校验和计算)
- [安装逻辑编写](#安装逻辑编写)
- [测试方法编写](#测试方法编写)
- [依赖关系定义](#依赖关系定义)
- [实用命令清单](#实用命令清单)
- [常见问题解答](#常见问题解答)

---

## 什么是 Formula？

Formula 是 Homebrew 的软件包定义文件，使用 Ruby 语言编写。每个 Formula 描述了：
- 软件的基本信息（名称、描述、主页）
- 下载地址和校验和
- 如何编译/安装软件
- 如何测试安装是否成功

Formula 文件存放在 `Formula/` 目录下，文件名以 `.rb` 结尾。

---

## 命名规范

### 文件名规范

- 使用**小写字母**
- 多个单词用**连字符 `-`** 连接
- 扩展名必须是 **`.rb`**

**示例：**
```
✅ my-app.rb
✅ awesome-tool.rb
✅ super-cli.rb
❌ MyApp.rb          # 不要用大写
❌ my_app.rb         # 不要用下划线
❌ myapp             # 缺少扩展名
```

### 类名规范

- 使用**驼峰命名法（CamelCase）**
- 必须继承自 `Formula` 类
- 类名应该与文件名对应

**转换规则：**
```
文件名            →    类名
my-app.rb        →    class MyApp < Formula
awesome-tool.rb  →    class AwesomeTool < Formula
super-cli.rb     →    class SuperCli < Formula
```

---

## Formula 基本结构

一个完整的 Formula 包含以下基本元素：

```ruby
class MyApp < Formula
  # 基本信息
  desc "简短的一句话描述"
  homepage "https://项目主页"
  url "下载地址"
  sha256 "校验和"
  license "许可证类型"

  # 依赖关系（可选）
  depends_on "dependency"

  # 安装方法
  def install
    # 安装逻辑
  end

  # 测试方法（推荐）
  test do
    # 测试逻辑
  end
end
```

### 必填字段

| 字段 | 说明 | 示例 |
|------|------|------|
| `desc` | 简短描述（一句话） | `"A fast and flexible static site generator"` |
| `homepage` | 项目主页 URL | `"https://github.com/user/project"` |
| `url` | 下载地址 | `"https://example.com/app-1.0.0.tar.gz"` |
| `sha256` | 文件校验和 | `"abc123..."` |
| `install` | 安装方法（def 块） | 见下文 |

### 推荐字段

| 字段 | 说明 | 示例 |
|------|------|------|
| `license` | 许可证类型 | `"MIT"`, `"Apache-2.0"`, `"GPL-3.0"` |
| `version` | 版本号 | `"1.0.0"` |
| `test` | 测试方法（def 块） | 见下文 |

---

## Ruby 下载定义的 4 种方式

### 方式 1: 固定 URL（最简单）

直接写死下载地址，适合简单场景。

```ruby
class MyApp < Formula
  desc "My awesome application"
  homepage "https://github.com/user/my-app"
  url "https://github.com/user/my-app/archive/v1.0.0.tar.gz"
  sha256 "abc123def456..."
  license "MIT"

  def install
    bin.install "my-app"
  end
end
```

**适用场景：**
- 单一平台
- 不经常更新版本
- 初学者练习

---

### 方式 2: 使用版本变量（推荐 ⭐）

定义 `version` 变量，在 `url` 中使用 `#{version}` 引用。

```ruby
class MyApp < Formula
  desc "My awesome application"
  homepage "https://github.com/user/my-app"
  version "1.0.0"
  url "https://github.com/user/my-app/releases/download/v#{version}/my-app-#{version}.tar.gz"
  sha256 "abc123def456..."
  license "MIT"

  def install
    bin.install "my-app"
  end
end
```

**优点：**
- 版本号统一管理
- 更新版本时只需修改 `version` 和 `sha256`
- URL 自动更新

**适用场景：**
- 正式项目（强烈推荐）
- 需要频繁更新版本
- URL 有规律的项目

---

### 方式 3: 多平台条件下载（多平台必备 ⭐⭐）

为不同操作系统和 CPU 架构提供不同的下载包。

```ruby
class MyApp < Formula
  desc "Cross-platform awesome tool"
  homepage "https://github.com/user/my-app"
  version "1.0.0"
  license "MIT"

  # macOS 平台
  on_macos do
    if Hardware::CPU.arm?
      # Apple Silicon (M1/M2/M3 等)
      url "https://github.com/user/my-app/releases/download/v#{version}/my-app-#{version}-macos-arm64.tar.gz"
      sha256 "arm64_checksum_aaaa..."
    else
      # Intel Mac
      url "https://github.com/user/my-app/releases/download/v#{version}/my-app-#{version}-macos-x86_64.tar.gz"
      sha256 "x86_64_checksum_bbbb..."
    end
  end

  # Linux 平台
  on_linux do
    url "https://github.com/user/my-app/releases/download/v#{version}/my-app-#{version}-linux-x86_64.tar.gz"
    sha256 "linux_checksum_cccc..."
  end

  def install
    bin.install "my-app"
  end
end
```

**关键语法：**
- `on_macos do ... end` - macOS 特定配置
- `on_linux do ... end` - Linux 特定配置
- `Hardware::CPU.arm?` - 判断是否为 ARM 架构
- `Hardware::CPU.intel?` - 判断是否为 Intel 架构

**适用场景：**
- 多平台支持的项目
- 提供预编译二进制的项目
- 需要针对不同架构优化的项目

---

### 方式 4: 条件 SHA256

当 URL 相同但不同平台 SHA256 不同时使用。

```ruby
class MyApp < Formula
  desc "Universal binary application"
  homepage "https://github.com/user/my-app"
  version "1.0.0"
  url "https://github.com/user/my-app/releases/download/v#{version}/my-app-#{version}.tar.gz"
  license "MIT"

  # 根据平台设置不同的 SHA256
  if OS.mac?
    if Hardware::CPU.arm?
      sha256 "arm64_sha256..."
    else
      sha256 "x86_64_sha256..."
    end
  elsif OS.linux?
    sha256 "linux_sha256..."
  end

  def install
    bin.install "my-app"
  end
end
```

**适用场景：**
- Universal Binary（通用二进制）
- 一个包包含多个架构
- 较少使用，方式 3 更清晰

---

## 版本号管理

### 版本号格式

遵循 **语义化版本（Semantic Versioning）** 规范：

```
主版本号.次版本号.修订号
  MAJOR . MINOR . PATCH

示例：1.2.3
```

**版本号含义：**
- **主版本号（MAJOR）**：不兼容的 API 修改
- **次版本号（MINOR）**：向下兼容的功能性新增
- **修订号（PATCH）**：向下兼容的问题修正

### 版本号更新

```ruby
# 推荐：定义 version 变量
version "1.2.3"

# 在 URL 中引用
url "https://github.com/user/app/releases/download/v#{version}/app-#{version}.tar.gz"
```

### 自动版本检测（Livecheck）

添加 `livecheck` 块，Homebrew 可以自动检测新版本：

```ruby
class MyApp < Formula
  # ... 其他配置 ...

  livecheck do
    url :stable
    strategy :github_latest
  end
end
```

---

## SHA256 校验和计算

### 为什么需要 SHA256？

SHA256 确保下载的文件：
1. **完整性**：文件没有损坏
2. **安全性**：文件没有被篡改
3. **一致性**：每次下载的都是同一个文件

### 计算方法

#### macOS / Linux

```bash
# 下载文件后计算
shasum -a 256 your-file.tar.gz

# 或使用 sha256sum (Linux)
sha256sum your-file.tar.gz
```

**示例输出：**
```
abc123def4567890abcdef1234567890abcdef1234567890abcdef123456789  your-file.tar.gz
```

将前面的长字符串填入 Formula 的 `sha256` 字段。

#### 多文件批量计算

```bash
# 批量计算多个文件的 SHA256
for file in *.tar.gz; do
  echo "=== $file ==="
  shasum -a 256 "$file"
done
```

### 使用示例

```ruby
class MyApp < Formula
  # ...
  url "https://example.com/app-1.0.0.tar.gz"
  # 将计算出的 SHA256 填入这里
  sha256 "abc123def4567890abcdef1234567890abcdef1234567890abcdef123456789"
  # ...
end
```

---

## 安装逻辑编写

`install` 方法定义了如何将软件安装到系统中。

### 预编译二进制（最常用）

适用于已经编译好的可执行文件。

```ruby
def install
  # 安装单个可执行文件
  bin.install "my-app"

  # 安装多个可执行文件
  bin.install "app1", "app2", "helper-tool"

  # 安装库文件
  lib.install Dir["lib/*"]

  # 安装文档
  (share/"doc/my-app").install "README.md", "LICENSE"

  # 安装配置文件示例
  (etc/"my-app").install "config.example.toml"

  # 安装 man 手册页
  man1.install "man/my-app.1"
end
```

### 基于 configure/make

适用于使用 Autotools 的项目。

```ruby
def install
  # 配置
  system "./configure",
    "--prefix=#{prefix}",
    "--disable-dependency-tracking",
    "--enable-feature"

  # 编译
  system "make"

  # 安装
  system "make", "install"
end
```

### 基于 CMake

适用于使用 CMake 构建的项目。

```ruby
def install
  mkdir "build" do
    # 配置
    system "cmake", "..",
      *std_cmake_args,
      "-DCMAKE_BUILD_TYPE=Release"

    # 编译
    system "make"

    # 安装
    system "make", "install"
  end
end
```

**说明：**
- `std_cmake_args` 是 Homebrew 提供的标准 CMake 参数
- 包括 `--prefix`, `--libdir` 等

### 基于 Python setup.py

适用于 Python 项目。

```ruby
def install
  system "python3", "setup.py", "install",
    "--prefix=#{prefix}",
    "--single-version-externally-managed",
    "--record=installed.txt"
end
```

### 安装路径变量

Formula 提供了以下路径变量：

| 变量 | 路径 | 用途 |
|------|------|------|
| `prefix` | `/usr/local/Cellar/<name>/<version>` | 安装根目录 |
| `bin` | `#{prefix}/bin` | 可执行文件 |
| `lib` | `#{prefix}/lib` | 库文件 |
| `include` | `#{prefix}/include` | 头文件 |
| `share` | `#{prefix}/share` | 共享数据 |
| `etc` | `#{prefix}/etc` | 配置文件 |
| `man` | `#{prefix}/share/man` | man 手册 |
| `man1` | `#{prefix}/share/man/man1` | man 第 1 章 |

---

## 测试方法编写

`test` 块用于验证安装是否成功，Homebrew 安装后会自动运行。

### 基本测试

```ruby
test do
  # 测试版本号
  assert_match version.to_s, shell_output("#{bin}/my-app --version")
end
```

### 常用测试方法

```ruby
test do
  # 1. 测试版本输出
  assert_match "1.0.0", shell_output("#{bin}/my-app --version")

  # 2. 测试帮助命令（只要不报错就行）
  system "#{bin}/my-app", "--help"

  # 3. 测试特定输出
  output = shell_output("#{bin}/my-app test-command")
  assert_match "expected output", output

  # 4. 测试文件是否存在
  assert_predicate bin/"my-app", :exist?

  # 5. 测试退出码
  assert_equal 0, $CHILD_STATUS.exitstatus
end
```

### 复杂测试示例

```ruby
test do
  # 创建测试文件
  (testpath/"test.txt").write "Hello, World!"

  # 运行程序处理文件
  system "#{bin}/my-app", "process", testpath/"test.txt"

  # 验证输出
  assert_predicate testpath/"output.txt", :exist?
  assert_match "processed", (testpath/"output.txt").read
end
```

---

## 依赖关系定义

### 运行时依赖

软件运行时必须的依赖。

```ruby
class MyApp < Formula
  # ...
  depends_on "openssl"
  depends_on "sqlite"
  # ...
end
```

### 构建时依赖

仅在编译时需要，运行时不需要。

```ruby
class MyApp < Formula
  # ...
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  # ...
end
```

### 可选依赖

提供额外功能的依赖。

```ruby
class MyApp < Formula
  # ...
  depends_on "graphviz" => :optional
  depends_on "imagemagick" => :optional
  # ...
end
```

### 系统库依赖

使用系统自带的库，不额外安装。

```ruby
class MyApp < Formula
  # ...
  uses_from_macos "zlib"
  uses_from_macos "libxml2"
  # ...
end
```

### 操作系统限制

```ruby
class MyApp < Formula
  # 仅支持 macOS
  depends_on :macos

  # 仅支持 Linux
  depends_on :linux

  # 要求特定 macOS 版本
  depends_on macos: :monterey  # macOS 12+
end
```

---

## 实用命令清单

### Formula 开发和测试

```bash
# 1. 创建新 Formula
cp Formula/template.rb.example Formula/my-app.rb

# 2. 编辑 Formula
vim Formula/my-app.rb

# 3. 检查语法和规范
brew audit --strict Formula/my-app.rb

# 4. 测试安装（从源代码/本地文件）
brew install --build-from-source Formula/my-app.rb

# 5. 运行测试
brew test my-app

# 6. 卸载
brew uninstall my-app

# 7. 查看 Formula 信息
brew info my-app

# 8. 编辑已安装的 Formula
brew edit my-app

# 9. 查看 Formula 的安装路径
brew --prefix my-app

# 10. 查看 Formula 的完整路径
brew formula my-app
```

### Tap 管理

```bash
# 添加 Tap
brew tap xiao_lfeng/tap

# 列出已添加的 Tap
brew tap

# 查看 Tap 信息
brew tap-info xiao_lfeng/tap

# 更新 Tap
brew update

# 移除 Tap
brew untap xiao_lfeng/tap
```

### 调试

```bash
# 启用详细输出
brew install --verbose --debug Formula/my-app.rb

# 查看安装日志
brew install --verbose my-app 2>&1 | tee install.log

# 进入交互式调试模式
brew irb
```

---

## 常见问题解答

### Q1: Formula 文件名和类名不匹配会怎样?

**A:** Homebrew 会报错，无法安装。确保：
```
文件名: my-app.rb  →  类名: class MyApp < Formula
```

### Q2: SHA256 填错了会怎样?

**A:** 安装时会报校验和不匹配错误，Homebrew 会拒绝安装。务必使用正确的 SHA256。

### Q3: 如何更新 Formula 版本?

**A:**
1. 修改 `version` 字段
2. 更新 `url`（如果使用了 `#{version}` 则自动更新）
3. 下载新版本的文件
4. 计算新的 SHA256
5. 更新 `sha256` 字段
6. 测试安装

### Q4: 多个可执行文件如何安装?

**A:**
```ruby
def install
  bin.install "app1", "app2", "app3"
end
```

### Q5: 如何处理配置文件?

**A:** 安装示例配置到 `etc` 目录：
```ruby
def install
  (etc/"my-app").install "config.example.toml"
end
```
用户可以复制并修改：
```bash
cp /usr/local/etc/my-app/config.example.toml ~/.config/my-app/config.toml
```

### Q6: 安装失败如何调试?

**A:**
```bash
# 使用详细输出和调试模式
brew install --verbose --debug Formula/my-app.rb

# 查看错误日志
brew gist-logs my-app
```

### Q7: 如何支持 Universal Binary（通用二进制）?

**A:** 使用条件判断：
```ruby
on_macos do
  if Hardware::CPU.arm?
    url "...arm64.tar.gz"
    sha256 "..."
  else
    url "...x86_64.tar.gz"
    sha256 "..."
  end
end
```

### Q8: 依赖的 Formula 在另一个 Tap 中怎么办?

**A:** 使用完整路径：
```ruby
depends_on "username/tap/formula-name"
```

### Q9: 如何禁用某些测试?

**A:** 使用条件跳过：
```ruby
test do
  return if ENV["CI"]  # 在 CI 环境中跳过
  # 测试代码
end
```

### Q10: Formula 中可以使用环境变量吗?

**A:** 可以：
```ruby
def install
  ENV["CUSTOM_VAR"] = "value"
  system "make", "install"
end
```

---

## 更多资源

- [Homebrew 官方文档](https://docs.brew.sh/)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew GitHub](https://github.com/Homebrew/brew)
- [Acceptable Formulae](https://docs.brew.sh/Acceptable-Formulae)

---

**编写时间：** 2025年

**维护者：** 筱锋 (xiao_lfeng)

**反馈：** 如有问题或建议，欢迎提交 Issue！
