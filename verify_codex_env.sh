#!/bin/bash
# Codex APP 环境验证脚本
# 用途：一键验证所有组件是否正常工作
# 作者：WorkBuddy AI
# 日期：2026-05-03

echo "========================================="
echo "   Codex APP 环境验证脚本"
echo "========================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 计数器
PASS=0
FAIL=0

# 验证函数
check_command() {
    local cmd=$1
    local name=$2
    local path=$3
    
    echo -n "验证 $name... "
    if [ -f "$path" ]; then
        echo -e "${GREEN}✓ 已安装${NC}"
        echo "  路径: $path"
        PASS=$((PASS + 1))
        return 0
    elif command -v $cmd &> /dev/null; then
        local cmd_path=$(command -v $cmd)
        echo -e "${GREEN}✓ 已安装${NC}"
        echo "  路径: $cmd_path"
        PASS=$((PASS + 1))
        return 0
    else
        echo -e "${RED}✗ 未找到${NC}"
        FAIL=$((FAIL + 1))
        return 1
    fi
}

check_version() {
    local cmd=$1
    local name=$2
    local version_flag=${3:---version}
    
    echo -n "验证 $name 版本... "
    if command -v $cmd &> /dev/null; then
        local version=$($cmd $version_flag 2>&1 | head -n 1)
        echo -e "${GREEN}✓ $version${NC}"
        PASS=$((PASS + 1))
        return 0
    else
        echo -e "${RED}✗ 命令不可用${NC}"
        FAIL=$((FAIL + 1))
        return 1
    fi
}

# 1. 验证 Node.js
echo "【1/7】验证 Node.js"
check_command "node" "Node.js" "/c/Program Files/nodejs/node.exe"
if [ -f "/c/Program Files/nodejs/node.exe" ]; then
    echo -n "验证 Node.js 版本... "
    version=$("/c/Program Files/nodejs/node.exe" --version 2>&1)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $version${NC}"
        PASS=$((PASS + 1))
    else
        echo -e "${YELLOW}⚠ 无法获取版本${NC}"
    fi
else
    FAIL=$((FAIL + 1))
fi
echo ""

# 2. 验证 npm
echo "【2/7】验证 npm"
check_command "npm" "npm" "/c/Program Files/nodejs/npm.cmd"
if [ -f "/c/Program Files/nodejs/npm.cmd" ]; then
    echo -n "验证 npm 版本... "
    # 使用 cmd /c 执行 .cmd 文件
    version=$(cmd /c "C:\Program Files\nodejs\npm.cmd --version" 2>&1)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $version${NC}"
        PASS=$((PASS + 1))
    else
        echo -e "${YELLOW}⚠ 无法获取版本${NC}"
    fi
else
    FAIL=$((FAIL + 1))
fi
echo ""

# 3. 验证 Git
echo "【3/7】验证 Git"
check_command "git" "Git" "/c/Program Files/Git/cmd/git.exe"
if [ $? -eq 0 ]; then
    check_version "git" "Git"
fi
echo ""

# 4. 验证 VSCode
echo "【4/7】验证 VSCode"
check_command "code" "VSCode" "/d/Program Files/Microsoft VS Code/Code.exe"
if [ $? -eq 0 ]; then
    check_version "code" "VSCode"
fi
echo ""

# 5. 验证 Codex
echo "【5/7】验证 Codex APP"
CODEX_PATH="$HOME/AppData/Local/Codex/Codex.exe"
check_command "codex" "Codex APP" "$CODEX_PATH"
if [ -f "$CODEX_PATH" ]; then
    echo -e "${GREEN}✓ Codex APP 已安装${NC}"
    echo "  路径: $CODEX_PATH"
    PASS=$((PASS + 1))
    
    # 尝试获取版本
    echo -n "  验证版本... "
    local_version=$("$CODEX_PATH" --version 2>&1 | head -n 1)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $local_version${NC}"
    else
        echo -e "${YELLOW}⚠ 无法获取版本（可能需要登录）$NC"
    fi
else
    FAIL=$((FAIL + 1))
fi
echo ""

# 6. 验证配置文件
echo "【6/7】验证 Codex 配置文件"
CONFIG_DIR="$HOME/.codex"
if [ -d "$CONFIG_DIR" ]; then
    echo -e "${GREEN}✓ 配置目录存在${NC}"
    echo "  路径: $CONFIG_DIR"
    PASS=$((PASS + 1))
    
    # 检查 AGENTS.md
    if [ -f "$CONFIG_DIR/AGENTS.md" ]; then
        echo -e "${GREEN}✓ AGENTS.md 已创建${NC}"
        PASS=$((PASS + 1))
    else
        echo -e "${YELLOW}⚠ AGENTS.md 未找到${NC}"
        FAIL=$((FAIL + 1))
    fi
    
    # 检查 config.toml
    if [ -f "$CONFIG_DIR/config.toml" ]; then
        echo -e "${GREEN}✓ config.toml 已创建${NC}"
        PASS=$((PASS + 1))
        
        # 检查 IDE 配置
        if grep -q 'ide = "vscode"' "$CONFIG_DIR/config.toml"; then
            echo -e "${GREEN}✓ IDE 已配置为 VSCode${NC}"
            PASS=$((PASS + 1))
        else
            echo -e "${YELLOW}⚠ IDE 未配置为 VSCode${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ config.toml 未找到${NC}"
        FAIL=$((FAIL + 1))
    fi
else
    echo -e "${RED}✗ 配置目录不存在${NC}"
    FAIL=$((FAIL + 1))
fi
echo ""

# 7. 验证环境变量
echo "【7/7】验证环境变量 PATH"
echo -n "  检查 Node.js 路径... "
if [[ ":$PATH:" == *":/c/Program Files/nodejs:"* ]]; then
    echo -e "${GREEN}✓ 已添加${NC}"
    PASS=$((PASS + 1))
else
    echo -e "${YELLOW}⚠ 未添加到当前会话 PATH${NC}"
    echo "  提示：请重启终端或执行："
    echo "  export PATH=\"\$PATH:/c/Program Files/nodejs:/c/Program Files/Git/cmd:/d/Program Files/Microsoft VS Code/bin\""
fi

echo -n "  检查 Git 路径... "
if [[ ":$PATH:" == *":/c/Program Files/Git/cmd:"* ]]; then
    echo -e "${GREEN}✓ 已添加${NC}"
    PASS=$((PASS + 1))
else
    echo -e "${YELLOW}⚠ 未添加到当前会话 PATH${NC}"
fi

echo -n "  检查 VSCode 路径... "
if [[ ":$PATH:" == *":/d/Program Files/Microsoft VS Code/bin:"* ]]; then
    echo -e "${GREEN}✓ 已添加${NC}"
    PASS=$((PASS + 1))
else
    echo -e "${YELLOW}⚠ 未添加到当前会话 PATH${NC}"
fi
echo ""

# 总结
echo "========================================="
echo "  验证完成"
echo "========================================="
echo -e "通过: ${GREEN}$PASS${NC}  失败: ${RED}$FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ 所有组件已正确安装和配置！${NC}"
    echo ""
    echo "下一步："
    echo "1. 启动 Codex APP（位于桌面或开始菜单）"
    echo "2. 登录 ChatGPT 账号"
    echo "3. 点击"设置沙箱"初始化"
    echo "4. 开始使用！"
    exit 0
else
    echo -e "${YELLOW}⚠ 有 $FAIL 项未通过验证，请检查上述输出${NC}"
    echo ""
    echo "建议："
    echo "1. 重启终端让环境变量生效"
    echo "2. 重新运行此脚本：bash /d/杂物间/verify_codex_env.sh"
    exit 1
fi
