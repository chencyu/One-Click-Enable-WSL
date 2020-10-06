@echo off  
chcp 65001 >nul  
  
:::::::::::::::: Check and Get Administrator permission ::::::::::::::::  
:CheckUAC  
:: Clear errorlevel  
cmd /c "exit /b 0"  
:: If `net session` cause errorlevel != 0, means we don't have admin acces  
net session >nul 2>nul  
if %errorlevel% == 0 (  
	goto :MainProg  
)  
  
:GetUAC  
:: run Start-Process with RunAs at this batch file in powershell  
set "ThisBatch=%~fp0"  
powershell.exe -NoProfile -Command Start-Process cmd -Verb RunAs -ArgumentList ("'/c'","'%ThisBatch%'")  
exit /b 0  
  
:MainProg  
set "CMDScriptRoot=%~dp0"  
set "CMDScriptRoot=%CMDScriptRoot:~0,-1%"  
:::::::::::::::: Check and Get Administrator permission ::::::::::::::::  
  
powershell.exe -ExecutionPolicy Bypass -File "%CMDScriptRoot%\scripts\script.ps1"
pause
