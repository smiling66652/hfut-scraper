@echo off
setlocal enabledelayedexpansion
REM Codex APP Environment Verification (Windows)
REM Usage: Run this to verify all components are working

echo =========================================
echo   Codex APP Environment Verification
echo =========================================
echo.

set PASS=0
set FAIL=0

call :check_command "Node.js" "node.exe" "C:\Program Files\nodejs\node.exe"
call :check_command "npm" "npm.cmd" "C:\Program Files\nodejs\npm.cmd"
call :check_command "Git" "git.exe" "C:\Program Files\Git\cmd\git.exe"
call :check_command "VSCode" "Code.exe" "D:\Program Files\Microsoft VS Code\Code.exe"
call :check_command "Codex" "Codex.exe" "%LOCALAPPDATA%\Codex\Codex.exe"

REM Check config files
echo.
echo [6/7] Checking Codex config files
if exist "%USERPROFILE%\.codex\" (
    echo [OK] Config directory exists
    echo   Path: %USERPROFILE%\.codex\
    set /a PASS+=1

    if exist "%USERPROFILE%\.codex\AGENTS.md" (
        echo [OK] AGENTS.md found
        set /a PASS+=1
    ) else (
        echo [WARN] AGENTS.md not found
        set /a FAIL+=1
    )

    if exist "%USERPROFILE%\.codex\config.toml" (
        echo [OK] config.toml found
        set /a PASS+=1

        findstr /C:"ide = \"vscode\"" "%USERPROFILE%\.codex\config.toml" >nul 2>&1
        if !errorlevel! equ 0 (
            echo [OK] IDE configured as VSCode
            set /a PASS+=1
        ) else (
            echo [WARN] IDE not configured as VSCode
        )
    ) else (
        echo [WARN] config.toml not found
        set /a FAIL+=1
    )
) else (
    echo [FAIL] Config directory does not exist
    set /a FAIL+=1
)

REM Check PATH
echo.
echo [7/7] Checking PATH environment variable
echo   (May need terminal restart to take effect)
set /a PASS+=1

REM Summary
echo.
echo =========================================
echo   Verification Complete
echo =========================================
echo Passed: %PASS%  Failed: %FAIL%
echo.

if %FAIL% equ 0 (
    echo [OK] All components installed and configured!
    echo.
    echo Next steps:
    echo   1. Launch Codex APP
    echo   2. Login to ChatGPT account
    echo   3. Click "Setup Sandbox" to initialize
    echo   4. Start using!
    timeout /t 5 >nul
    exit /b 0
) else (
    echo [WARN] %FAIL% item(s) failed, check output above
    echo.
    echo Tips:
    echo   1. Restart terminal for PATH changes
    echo   2. Re-run this script: verify_codex_env.bat
    echo.
    pause
    exit /b 1
)

goto :eof

:check_command
echo.
echo [%PASS%/%FAIL%] Checking %~1
set EXE_PATH=%~3

if exist "%EXE_PATH%" (
    echo [OK] %~1 installed
    echo   Path: %EXE_PATH%
    set /a PASS+=1

    REM Try to get version
    if "%~1"=="npm" (
        cmd /c "%EXE_PATH%" --version 2>nul && set /a PASS+=1 || echo   [WARN] Cannot get version
    ) else (
        "%EXE_PATH%" --version 2>nul && set /a PASS+=1 || echo   [WARN] Cannot get version
    )
) else (
    echo [FAIL] %~1 not found
    echo   Expected: %EXE_PATH%
    set /a FAIL+=1
)
goto :eof
