@echo off
REM ============================================================
REM  Codex APP 自动化安装脚本 （Windows x64）
REM  作者：WorkBuddy 自动生成
REM  说明：双击运行，自动完成所有可自动化的安装步骤
REM  需要网络（国内镜像源），需要管理员权限（部分步骤）
REM ============================================================

setlocal EnableDelayedExpansion

echo ================================================
echo  Codex APP 一键安装脚本
echo ================================================
echo.

REM --- 步骤 1：检查 Node.js ---
echo [1/6] 检查 Node.js...
where node >nul 2>&1
if %errorlevel%==0 (
    echo    Node.js 已安装
    node --version
) else (
    echo    Node.js 未安装，开始安装...
    if exist "%TEMP%\node-installer.msi" (
        msiexec /i "%TEMP%\node-installer.msi" /qn /norestart ADD_PATH=1
        echo    安装完成，请重启后继续
    ) else (
        echo    [警告] 未找到安装包，请手动安装 Node.js
    )
)

REM --- 步骤 2：检查 Git ---
echo.
echo [2/6] 检查 Git...
where git >nul 2>&1
if %errorlevel%==0 (
    echo    Git 已安装
    git --version
) else (
    echo    Git 未安装，开始静默安装...
    if exist "%TEMP%\git-installer.exe" (
        "%TEMP%\git-installer.exe" /VERYSILENT /NORESTART /SP-
        echo    安装完成
    ) else (
        echo    [警告] 未找到安装包，请手动安装 Git
    )
)

REM --- 步骤 3：检查 VSCode ---
echo.
echo [3/6] 检查 VSCode...
where code >nul 2>&1
if %errorlevel%==0 (
    echo    VSCode 已安装
    code --version
) else (
    echo    VSCode 未安装，开始安装...
    if exist "%TEMP%\vscode-user-installer.exe" (
        "%TEMP%\vscode-user-installer.exe" /VERYSILENT /NORESTART
        echo    安装完成
    ) else (
        echo    [警告] 未找到安装包，请手动安装 VSCode
    )
)

REM --- 步骤 4：配置 Git 全局设置（需要用户输入）---
echo.
echo [4/6] Git 全局配置...
echo    注意：请手动运行以下命令（按提示输入你的信息）：
echo    git config --global user.name "你的名字"
echo    git config --global user.email "你的邮箱"
echo    git config --global core.autocrlf false
echo.

REM --- 步骤 5：创建全局 AGENTS.md ---
echo [5/6] 创建全局 AGENTS.md...
set "AGENTS_DIR=%USERPROFILE%\.codex"
if not exist "%AGENTS_DIR%" mkdir "%AGENTS_DIR%"

(
echo # AGENTS.md - Codex 全局指南
echo.
echo ^> 此文件对所有 Codex 项目生效
echo.
echo ## 用户背景
echo - 学校：合肥工业大学（宣城校区^）
echo - 专业：机械工程
echo - 目标：保研（电气工程/计算机方向^）
echo - 技术栈：Python, Git, Web开发, AI工具
echo.
echo ## 工作偏好
echo - 语言：中文
echo - 风格：简洁实用，直接给结果
echo - 代码规范：详细注释，中英文皆可
echo.
echo ## 安全规则
echo - 禁止批量删除文件/目录（只能逐个删除^）
echo - 禁止未经确认修改沙箱外文件
echo - 网络请求需先说明目的
echo.
echo ## 常用技术栈
echo - Python 3.x（数据处理、爬虫^）
echo - Git（版本控制^）
echo - Markdown（文档编写^）
echo - HTML/CSS/JS（前端基础^）
) > "%AGENTS_DIR%\AGENTS.md"

if exist "%AGENTS_DIR%\AGENTS.md" (
    echo    已创建：%AGENTS_DIR%\AGENTS.md
) else (
    echo    [警告] 创建失败，请手动创建
)

REM --- 步骤 6：提示手动步骤 ---
echo.
echo [6/6] 生成后续操作清单...
echo.
echo ================================================
echo  自动化安装完成！
echo  以下步骤需要你手动完成：
echo ================================================
echo.
echo [待办] 1. 安装 Codex APP
echo    打开 Microsoft Store 搜索 "Codex" 并安装
echo.
echo [待办] 2. 登录 ChatGPT 账号
echo    启动 Codex APP → 用 ChatGPT 账号登录
echo.
echo [待办] 3. 初始化沙箱
echo    首次启动 Codex 后点击"设置沙箱"
echo.
echo [待办] 4. 配置 GitHub（如需代码推送^）
echo    需要 GitHub 账号 + 配置 SSH 密钥
echo.
echo [待办] 5. 配置 Git 用户信息（如未配置^）
echo    git config --global user.name "你的名字"
echo    git config --global user.email "你的邮箱"
echo.
echo 详细说明请查看配套文档：
echo   Codex_APP_完整安装指南.md
echo.
pause
endlocal
