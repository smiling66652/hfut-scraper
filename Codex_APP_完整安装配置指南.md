# Codex APP — 完整安装与配置指南

> **整理时间**：2026-05-02
> **作者**：WorkBuddy 自动生成
> **来源**：技术爬爬虾 B站教程（cv48333875）
> **平台**：Windows 11（MateBook E 2022）

---

## 进度总览

| 序号 | 步骤 | 状态 | 说明 |
|------|------|------|------|
| 1 | 安装 Node.js | ✅ 已完成 | 自动完成，v22.15.0 |
| 2 | 安装 Git | ✅ 已完成 | 自动完成，v2.47.1 |
| 3 | 安装 VSCode | ✅ 已完成 | 自动完成，v1.100.2 |
| 4 | 下载 Codex APP | ⚠️ 需手动 | Microsoft Store 专属 |
| 5 | 安装 Codex APP | ⚠️ 需手动 | Microsoft Store 专属 |
| 6 | 登录 ChatGPT 账号 | ⚠️ 需手动 | 需要你的账号密码 |
| 7 | 首次设置工作类型 | ⚠️ 需手动 | Codex 首次启动引导 |
| 8 | 初始化沙箱 | ⚠️ 需手动 | 点击"设置沙箱"按钮 |
| 9 | 设置默认 IDE | ⚠️ 需手动 | VSCode 路径配置 |
| 10 | 配置 GitHub 账号 | ⚠️ 需手动 | SSH 密钥配置 |
| 11 | 编写全局 AGENTS.md | ✅ 已完成 | 已创建 `C:\Users\Matebook\.codex\AGENTS.md` |
| 12 | 创建 GitHub 仓库 | ⚠️ 需手动 | GitHub 网站操作 |
| 13 | 安装第三方 Skills | ⚠️ 需手动 | 下载 zip → 解压到项目 |
| 14 | 配置 MCP 服务器 | ⚠️ 需手动 | 需要账户和授权 |
| 15 | 安装 Netlify 插件 | ⚠️ 需手动 | 需要 GitHub 授权 |
| 16 | Computer Use 插件 | ❌ Windows 不支持 | 仅限 macOS |
| 17 | 开启防休眠（Mac） | ❌ Windows 不适用 | 仅限 macOS |

---

## 第一部分：已自动完成（你不需要操作）

### ✅ 1. Node.js v22.15.0（LTS）

- **安装路径**：`C:\Program Files\nodejs\`
- **版本**：Node.js v22.15.0 / npm 10.9.2 / npx 10.9.2
- **注意**：新打开的终端窗口才能直接使用 `node` / `npm` / `npx` 命令
- **PowerShell 问题**：npm/npx 的 `.ps1` 脚本会被执行策略拦截，替代方案：
  ```
  npm.cmd --version    # 代替 npm --version
  npx.cmd --version   # 代替 npx --version
  ```
  或修改执行策略：`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

### ✅ 2. Git v2.47.1

- **安装路径**：`C:\Program Files\Git\`
- **可执行文件**：`C:\Program Files\Git\bin\git.exe`
- **验证**：在新终端中运行 `git --version`

### ✅ 3. VSCode v1.100.2（用户模式）

- **安装路径**：`C:\Users\Matebook\AppData\Local\Programs\Microsoft VS Code\`
- **命令**：`code` 命令在新终端中可用
- **验证**：运行 `code --version`

### ✅ 4. 全局 AGENTS.md

- **路径**：`C:\Users\Matebook\.codex\AGENTS.md`
- **作用**：对所有 Codex 项目生效，每次新对话自动读取
- **内容已包含**：
  - 你的学校/专业/保研目标
  - 工作偏好（中文、简洁实用）
  - 安全规则（禁止批量删除等）
  - 常用技术栈

---

## 第二部分：需要你手动完成的步骤

### 🔴 步骤 4-6：安装并登录 Codex APP

**Codex APP 只能通过 Microsoft Store 安装**

```
步骤 1：打开 Microsoft Store
步骤 2：搜索 "Codex"
步骤 3：点击"获取"或"安装"
步骤 4：安装完成后启动 Codex APP
步骤 5：使用你的 ChatGPT 账号登录
  - 免费账户可用（额度较低）
  - Plus/Pro 账户额度更高
步骤 6：首次引导：
  - 选择希望 Codex 处理的工作类型（会预装对应插件和 Skills）
  - 选择主要使用场景：编程 / 日常工作
```

> ⚠️ **重要**：如果 Microsoft Store 无法访问，需先修复网络或使用代理。

---

### 🔴 步骤 7-8：首次设置 + 初始化沙箱

**启动 Codex APP 后**：

```
步骤 1：选择工作类型
  → 推荐选择"编程"（会预装代码相关插件）
  → 后续可在设置中修改

步骤 2：点击"设置沙箱"按钮
  → Codex 会自动配置 Windows 沙箱
  → 这是权限系统的基础设施（详见教程第三章）

步骤 3：选择默认 IDE
  → 设置 → 常规设置 → 选择默认 IDE
  → 选择 VSCode（已自动安装）
  → 也可选择 Cursor、WebStorm 等
```

---

### 🟡 步骤 9：配置 Git 用户信息（可选但推荐）

打开终端，运行：

```bash
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
git config --global core.autocrlf false
```

---

### 🟡 步骤 10-12：GitHub 配置（如需代码推送）

**只有在需要把代码推送到 GitHub 时才需要配置**

```
步骤 1：注册 GitHub 账号
  → https://github.com/

步骤 2：生成 SSH 密钥（推荐）
  → 打开 Git Bash 或 PowerShell
  → 运行：ssh-keygen -t ed25519 -C "你的邮箱"
  → 一路回车（使用默认路径）

步骤 3：添加 SSH 密钥到 GitHub
  → 复制公钥：cat ~/.ssh/id_ed25519.pub
  → 打开 GitHub → Settings → SSH and GPG keys
  → New SSH key → 粘贴公钥 → 保存

步骤 4：测试连接
  → ssh -T git@github.com
  → 看到 "Hi 用户名!" 即成功

步骤 5：在 GitHub 创建仓库
  → 右上角 + → New repository
  → 填写仓库名 → Create repository
  → 复制仓库地址（HTTPS 或 SSH）
```

在 Codex 中推送代码：
```
提示词：帮我把代码推送到 https://github.com/你的用户名/仓库名.git
```

---

### 🟡 步骤 13：安装第三方 Skills（按需）

```
步骤 1：找到需要的 Skill
  → 官方 Skills：Codex 内 → 插件与技能 → 官方技能
  → 第三方 Skills：从 GitHub 下载（如歸藏的电子杂志风 PPT Skill）

步骤 2：安装到项目
  → 如果是官方 Skill：直接用 / 唤起，按提示安装
  → 如果是第三方 Skill：
    1. 下载 zip 文件
    2. 解压到 项目根目录/.codex/skills/ 文件夹
    3. 重启 Codex（使 Skill 生效）

步骤 3：使用 Skill
  → 输入 / → 选择对应 Skill → 按提示使用
```

---

### 🟡 步骤 14：配置 MCP 服务器（按需）

**以 Supabase MCP 为例**：

```
步骤 1：在 Supabase 创建项目
  → https://supabase.com/
  → New project → 填写信息 → Create

步骤 2：获取 MCP 连接 URL
  → Supabase 项目 → Project Settings → API
  → Connect → MCP 客户端 → 选择 Codex
  → 复制 URL

步骤 3：在 Codex 中配置
  → 左下角设置 → MCP 服务器
  → 添加服务器 → 选择"流式 HTTP 传输方式"
  → 填写 URL → 保存

步骤 4：授权
  → 打开终端 → 按提示输入命令
  → 浏览器打开授权页面 → 授权

步骤 5：⚠️ 重启 Codex（必须）
```

---

### 🟡 步骤 15：安装 Netlify 插件（按需）

```
步骤 1：在 Codex 中安装 Netlify 插件
  → 插件市场 → 搜索 Netlify → 安装

步骤 2：授权 GitHub 登录 Netlify
  → 按提示完成 GitHub OAuth 授权

步骤 3：部署项目
  → 提示词："帮我把项目部署到 Netlify 上面"
  → Codex 自动完成构建和部署
  → 部署成功后获得公网域名
```

---

### ❌ 步骤 16-17：Windows 不支持的功能

| 功能 | 说明 |
|------|------|
| Computer Use 插件 | 仅限 macOS，Windows 无法使用 |
| 防休眠设置 | 仅限 macOS（设置 → 运行时防止系统休眠） |

---

## 第三部分：快速验证清单

完成手动步骤后，逐一验证：

```
□ Node.js 可用：   node --version        （应显示 v22.15.0）
□ npm 可用：      npm.cmd --version     （应显示 10.9.2）
□ Git 可用：      git --version         （应显示 2.47.1）
□ VSCode 可用：   code --version        （应显示 1.100.2）
□ Codex APP 已安装（Microsoft Store 中确认）
□ Codex APP 已登录（启动后能进入主界面）
□ 沙箱已初始化（Codex 设置中确认）
□ 默认 IDE 已设置（Codex 设置 → VSCode）
□ AGENTS.md 已生效（Codex 新对话中会读取）
```

---

## 第四部分：附送文件说明

本指南配套以下自动生成的文件：

| 文件 | 路径 | 说明 |
|------|------|------|
| 保姆级全攻略说明书 | `d:\杂物间\Codex_APP_保姆级全攻略_说明书.md` | 16 章节完整教程 |
| 本安装配置指南 | `d:\杂物间\Codex_APP_完整安装配置指南.md` | 本文档 |
| 全局 AGENTS.md | `C:\Users\Matebook\.codex\AGENTS.md` | Codex 全局配置（已创建）|
| 一键安装脚本 | `d:\杂物间\Codex一键安装脚本.bat` | 自动化安装脚本（仅供参考）|

---

## 第五部分：常见问题

### Q1：Microsoft Store 无法打开怎么办？

尝试以下方法：
1. 检查网络（是否需要代理）
2. 运行 `wsreset.exe` 重置 Store 缓存
3. 手动下载 APPX 包安装（较难，不推荐）

### Q2：Codex APP 启动后卡在沙箱初始化？

1. 确认 Windows 沙箱功能已开启：
   - 控制面板 → 程序 → 启用或关闭 Windows 功能 → 勾选"Windows 沙箱"
2. 重启电脑后再试

### Q3：VSCode 的 `code` 命令不识别？

重新安装 VSCode，安装时勾选"添加到 PATH"选项。或手动添加：
```
C:\Users\Matebook\AppData\Local\Programs\Microsoft VS Code\bin
```
到系统 PATH 环境变量。

### Q4：AGENTS.md 不生效？

1. 确认路径正确：`C:\Users\Matebook\.codex\AGENTS.md`
2. 重启 Codex APP
3. Codex 新对话时会自动读取，旧对话不会生效

---

> **最后更新**：2026-05-02
> **生成工具**：WorkBuddy + OpenAI GPT
> **问题反馈**：查看 `d:\杂物间\` 目录下的配套文档
