@echo off
setlocal
chcp 65001 >nul 2>&1

cd %~dp0\..

set itemName="在此处打开 MySYS64 终端(&T)"
set exePath=%__CD__%terminal.exe
set regPath1=HKCR\Directory\shell\MySYS64
set regPath2=HKCR\Directory\background\shell\MySYS64

reg query %regPath1% /s >nul 2>&1
if %errorlevel% == 0 (
    reg delete %regPath1% /f >nul 2>&1
    reg delete %regPath2% /f >nul 2>&1
) else (
    reg add %regPath1% /ve /d %itemName% >nul 2>&1
    reg add %regPath1%\command /ve /d %exePath% >nul 2>&1
    reg add %regPath2% /ve /d %itemName% >nul 2>&1
    reg add %regPath2%\command /ve /d %exePath% >nul 2>&1
)
