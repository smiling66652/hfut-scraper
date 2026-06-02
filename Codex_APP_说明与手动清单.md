Codex APP 完整安装说明
& 手动操作清单
WorkBuddy AI 自动生成 · 2026-05-03
合肥工业大学（宣城校区）机械工程专业

一、项目进度总览
AI 已自动完成所有可自动化步骤。你只需完成 3 项手动操作（约 10–15 分钟）即可开始使用 Codex APP。

二、已安装组件详情（AI 已完成）

📁 配置文件位置

三、⚠️ 手动操作清单（你需要完成）
下列步骤 AI 无法代劳（需要你的账号 / 点击确认），请按顺序完成。 预计总耗时：10–15 分钟

✅ 手动操作 Checklist（打勾确认）
□  [必须]  启动 Codex APP（运行 start_codex.bat 或桌面图标）
□  [必须]  登录 ChatGPT Plus 账号
□  [必须]  初始化沙箱（Setup Sandbox，等待完成）
□  [可选]  配置 GitHub SSH + Codex 授权
□  [可选]  安装 Netlify / MCP 等插件

四、常用命令速查

五、常见问题排除
Q: 命令未找到（node/git/code）
原因：新安装后需重启终端，环境变量才生效。
解决：关闭当前终端，重新打开；或运行 verify_codex_env.bat 查看状态。
Q: PowerShell 提示"无法加载 npm.ps1"
原因：执行策略限制。
解决：改用 npm.cmd 替代 npm；或以管理员身份执行：
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Q: Codex 无法启动沙箱
原因：Windows Sandbox 功能未启用。
解决：控制面板 → 程序 → 启用或关闭 Windows 功能 → 勾选"Windows 沙盒" → 重启。
Q: 登录 ChatGPT 失败
原因：网络访问受限，或账号未开通 Plus。
解决：检查网络连接；确认 ChatGPT 账号为 Plus 或以上订阅。

附：所有生成文件位置
按照手动操作清单完成 3 项必须步骤后，即可正式使用 Codex APP。祝你顺利！🚀