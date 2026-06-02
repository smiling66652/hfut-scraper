# Codex APP 项目复刻 - 最终交付报告

**项目时间**：2026-05-02 至 2026-05-03  
**执行者**：WorkBuddy AI  
**用户**：合肥工业大学（宣城校区）机械工程专业  

---

## 📋 项目概述

根据 B站教程（https://www.bilibili.com/opus/1196732919815602198），成功复刻 Codex APP 开发环境，完成所有可自动化步骤。

---

## ✅ 已完成（AI 自动执行）

### 1. 环境安装

| 组件 | 版本 | 安装路径 | 状态 |
|------|------|----------|------|
| **Node.js** | v22.15.0 | `C:\Program Files\nodejs\` | ✅ 已完成 |
| **npm** | 10.9.2 | `C:\Program Files\nodejs\` | ✅ 已完成 |
| **Git** | v2.47.1 | `C:\Program Files\Git\` | ✅ 已完成 |
| **VSCode** | v1.118.1 | `D:\Program Files\Microsoft VS Code\` | ✅ 已完成 |
| **Codex APP** | v24.11.1 | `C:\Users\Matebook\AppData\Local\Codex\` | ✅ 已完成 |

### 2. 配置文件

| 文件 | 路径 | 说明 |
|------|------|------|
| **AGENTS.md** | `C:\Users\Matebook\.codex\AGENTS.md` | 全局 AI 配置（含用户背景、安全规则） |
| **config.toml** | `C:\Users\Matebook\.codex\config.toml` | Codex 配置文件（IDE 已设为 VSCode） |

### 3. 辅助脚本

| 脚本 | 路径 | 用途 |
|------|------|------|
| **verify_codex_env.sh** | `d:\杂物间\verify_codex_env.sh` | Bash 环境验证脚本 |
| **verify_codex_env.bat** | `d:\杂物间\verify_codex_env.bat` | Windows 环境验证脚本 |
| **start_codex.bat** | `d:\杂物间\start_codex.bat` | Codex 快速启动脚本 |

### 4. 文档生成

| 文档 | 路径 | 说明 |
|------|------|------|
| **Codex_APP_保姆级全攻略_说明书.md** | `d:\杂物间\Codex_APP_保姆级全攻略_说明书.md` | 16章节完整教程 |
| **Codex_APP_完整安装配置指南.md** | `d:\杂物间\Codex_APP_完整安装配置指南.md` | 安装配置快速指南 |

---

## ⚠️ 需用户手动完成

### 第一步：启动并登录 Codex

1. **启动 Codex APP**
   - 方法1：双击桌面图标（如有）
   - 方法2：开始菜单搜索 "Codex"
   - 方法3：运行 `start_codex.bat` 脚本

2. **登录 ChatGPT 账号**
   - 点击 "Login" 或 "Sign in"
   - 使用你的 ChatGPT 账号登录（需要 Plus 订阅）

### 第二步：初始化沙箱

1. 登录后，点击界面中的 **"设置沙箱"** 或 **"Setup Sandbox"**
2. 等待初始化完成（需要下载沙箱镜像，约 5-10 分钟）

### 第三步：配置 IDE（已自动配置）

- ✅ 已在 `config.toml` 中设置 `ide = "vscode"`
- 如需手动确认：Codex 界面 → Settings → Default IDE → 选择 "Visual Studio Code"

### 第四步（可选）：配置 GitHub

如果需要将代码推送到 GitHub：

1. **生成 SSH 密钥**（如未配置）
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. **添加 SSH 密钥到 GitHub**
   - 复制公钥：`cat ~/.ssh/id_ed25519.pub`
   - 访问 GitHub → Settings → SSH and GPG keys → New SSH key
   - 粘贴并保存

3. **授权 Codex 访问 GitHub**
   - Codex 界面 → Settings → Integrations → GitHub → Connect

### 第五步（可选）：安装插件

根据需求安装以下插件：

- **Netlify 插件**：用于部署网页应用
- **MCP 服务器**：用于扩展功能（如数据库、API 等）

---

## 🔧 验证安装

### 方法1：运行验证脚本

**Windows 用户**：
```cmd
d:\杂物间\verify_codex_env.bat
```

**Git Bash 用户**：
```bash
bash /d/杂物间/verify_codex_env.sh
```

### 方法2：手动验证

打开新的终端（PowerShell 或 Git Bash），执行：

```bash
# 验证 Node.js
node --version
npm --version

# 验证 Git
git --version

# 验证 VSCode
code --version
```

如果提示"命令未找到"，请重启终端或执行：
```bash
export PATH="$PATH:/c/Program Files/nodejs:/c/Program Files/Git/cmd:/d/Program Files/Microsoft VS Code/bin"
```

---

## 📝 使用流程

### 基本使用

1. **启动 Codex**
   - 运行 `start_codex.bat` 或直接启动 Codex APP

2. **输入任务**
   - 在对话框中描述你想完成的任务
   - 例如："帮我创建一个 Python 爬虫，抓取天气预报"

3. **审查代码**
   - Codex 会生成代码并在 VSCode 中打开
   - 审查代码，确认无误

4. **执行任务**
   - 点击 "Run" 或允许 Codex 执行
   - 查看输出结果

### 高级功能

- **沙箱测试**：在隔离环境中安全运行代码
- **多文件编辑**：同时编辑多个文件
- **版本控制**：自动 git commit
- **插件扩展**：连接数据库、API 等外部服务

---

## 🛠️ 故障排除

### 问题1：Node.js 或 npm 命令未找到

**原因**：环境变量未刷新  
**解决**：
1. 重启终端
2. 或手动添加 PATH：
   ```bash
   export PATH="$PATH:/c/Program Files/nodejs:/c/Program Files/Git/cmd"
   ```

### 问题2：PowerShell 执行策略错误

**原因**：npm.ps1 被 PowerShell 执行策略阻止  
**解决**：
1. 使用 `npm.cmd` 代替 `npm`
2. 或修改执行策略（管理员权限）：
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

### 问题3：Codex 无法启动沙箱

**原因**：Windows 沙箱功能未启用  
**解决**：
1. 控制面板 → 程序 → 启用或关闭 Windows 功能
2. 勾选 "Windows Sandbox"
3. 重启电脑

### 问题4：Git 克隆失败

**原因**：网络连接问题  
**解决**：
1. 使用镜像站（如 ghfast.top）
2. 配置 Git 代理（如有）

---

## 📚 补充说明

### AGENTS.md 配置内容

已为你自动生成 `AGENTS.md`，包含：
- 你的背景（合工大机械工程，目标保研电气/计算机）
- 安全规则（禁止批量删除、限制沙箱外操作）
- 文件管理风格（简洁实用，行动导向）
- 技术栈偏好（Python, MATLAB, SolidWorks）

### config.toml 配置内容

已为你自动生成 `config.toml`，包含：
- 默认模型：gpt-5.5（可修改）
- IDE：VSCode（已配置）
- 沙箱模式：windows-native
- 权限模式：auto-review（自动审查）
- 插件：启用了浏览器自动化、Word、Excel、PPT

---

## 🎯 下一步建议

1. **熟悉 Codex 界面**（15分钟）
   - 观看 B站教程视频
   - 尝试简单的任务（如"创建一个 Hello World 程序"）

2. **测试沙箱功能**（30分钟）
   - 创建一个测试项目
   - 运行代码，观察沙箱行为

3. **集成 GitHub**（可选，30分钟）
   - 配置 SSH 密钥
   - 尝试推送代码到仓库

4. **探索插件**（按需）
   - 根据需要安装 Netlify、MCP 等插件

---

## 📞 支持与反馈

如有问题，可以：
1. 查看 `d:\杂物间\Codex_APP_保姆级全攻略_说明书.md`（详细教程）
2. 查看 `d:\杂物间\Codex_APP_完整安装配置指南.md`（快速指南）
3. 运行验证脚本查看详细错误信息
4. 向 WorkBuddy 提问（我会记住这次配置）

---

## 🎉 总结

✅ **已完成**：5 个工具安装，2 个配置文件，3 个辅助脚本，2 份文档  
⚠️ **需手动**：登录 ChatGPT，初始化沙箱，配置 GitHub（可选）  
⏱️ **预计耗时**：手动操作约 10-15 分钟  

**祝你使用愉快！** 🚀

---

*本文档由 WorkBuddy AI 自动生成 - 2026-05-03*
