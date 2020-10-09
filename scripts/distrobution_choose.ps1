
$DistroURL = `
@{
    Ubuntu1604="https://aka.ms/wsl-ubuntu-1604";
    Ubuntu1804="https://aka.ms/wsl-ubuntu-1804";
    Ubuntu2004="https://aka.ms/wslubuntu2004";
    Debian    ="https://aka.ms/wsl-debian-gnulinux";
    Kali      ="https://aka.ms/wsl-kali-linux-new";
}

$DistroList = `
@(
    $DistroURL.keys
) -join "`n    "

$ChoosePrompt = "`
請輸入所要安裝的Linux發行版:
    $DistroList
"

$DistroAppx = "$Env:TMP\wsl_distro.appx"

do
{
    $abort = $true
    $Distro = Read-Host -Prompt $ChoosePrompt
    if ($Distro -in $DistroURL.keys) { $abort = $false }
} while($abort)


$ErrorActionPreferenceBak = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
if (Get-Command -Name "$Distro")
{
    Write-Host "已經安裝 $Distro 了！"
    Write-Host "終止程式..."
    $ErrorActionPreference = $ErrorActionPreferenceBak
    Exit
}
$ErrorActionPreference = $ErrorActionPreferenceBak


$ProgressPreferenceBak = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'
Write-Host "`n下載中...`n"
Invoke-WebRequest -Uri $DistroURL.$Distro -OutFile $DistroAppx -UseBasicParsing
Write-Host "`n安裝中...`n"
Add-AppxPackage -Path $DistroAppx
$ProgressPreference = $ProgressPreferenceBak

Remove-Item -Path $DistroAppx


Start-Process -FilePath "$Distro.exe"
