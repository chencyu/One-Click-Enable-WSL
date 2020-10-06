#Requires -RunAsAdministrator

if(Test-Path -Path "$PSScriptRoot\wsl2.tmp")
{
    & "$PSScriptRoot\wsl2_config.ps1"
    Remove-Item -Path "$PSScriptRoot\wsl2.tmp"
    Exit
}

#region     [Get system information]

# [Reference](https://docs.microsoft.com/zh-tw/windows-hardware/manufacture/desktop/use-dism-in-windows-powershell-s14)
$WSL_Disabled = (Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux").State -eq "Disabled"
$WinVer = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ReleaseId).ReleaseId

#endregion  [Get system information]


do
{
    $WSL = "1"
    if ([Int32]$WinVer -ge 2004)
    {
        # WSL2 only support version above 2004 on win10
        $WSL = Read-Host -Prompt "[請問要安裝 WSL1 還是 WSL2 ?] (1/2)"
    }


    if ($WSL -ne "1" -and $WSL -ne "2") { $abort = $true }
    else { $abort = $false }
} while ($abort)





if ($WSL_Disabled)
{
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -NoRestart
    if ($WSL -eq "2")
    {
        Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All -NoRestart
        Write-Output "wsl2" > "$PSScriptRoot\wsl2.tmp"
        Write-Host "關閉此視窗，重新開機"
        Write-Host "重新開機後再執行一次此腳本"
        Read-Host
        Exit
    }

    Write-Host "關閉此視窗並重新開機"
    Read-Host
    Exit
}


Write-Host "完成！"
Start-Sleep -Seconds 1
Write-Host "請至 Microsoft Store下載自己需要的 Linux 發行版"
Write-Host "Ex. Ubuntu, Kali Linux ... 等等"



