@echo off
REM Codex APP Quick Launch
REM Auto-start VSCode + Codex

echo ================================
echo    Codex APP Quick Launch
echo ================================
echo.

REM Extend PATH
set "PATH=%PATH%;C:\Program Files\nodejs;C:\Program Files\Git\cmd;D:\Program Files\Microsoft VS Code\bin"

REM Launch VSCode
echo Starting VSCode...
start "" "D:\Program Files\Microsoft VS Code\Code.exe"

REM Wait
timeout /t 2 >nul

REM Launch Codex APP
echo Starting Codex APP...
start "" "%LOCALAPPDATA%\Codex\Codex.exe"

echo.
echo [OK] VSCode and Codex APP launched.
echo.
echo Next steps:
echo   1. Login to ChatGPT account in Codex
echo   2. Click "Setup Sandbox" to initialize
echo   3. Start using!
echo.
pause
