@echo off  
chcp 65001 >nul  
  
set "CMDScriptRoot=%~dp0"  
set "CMDScriptRoot=%CMDScriptRoot:~0,-1%"  

powershell.exe -ExecutionPolicy Bypass -File "%CMDScriptRoot%\scripts\distrobution_choose.ps1"
