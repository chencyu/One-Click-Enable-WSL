#Requires -RunAsAdministrator

$LASTEXITCODE = 0
wsl --set-default-version 2
if ($LASTEXITCODE -ne 0)
{
    Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "${Env:TMP}\wsl_update_x64.msi"
    msiexec /i "${Env:TMP}\wsl_update_x64.msi" /quiet
}
wsl --set-default-version 2

if ($LASTEXITCODE -eq 0)
{
    Write-Host "Success!!!!!"
    Read-Host
    Exit
}

Write-Host "Error occur!!!!!"
Read-Host
