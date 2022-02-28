<#
    Name: Install-Sysinternals.ps1
    Description: Copies the windows sysinternals utilites to %systemroot%\ProgramData\TECH for use by help desk 
#>

$dlPath = "\\live.sysinternals.com\Tools"
$outPath = "C:\ProgramData\TECH"

if(!(Test-Path $outPath)) {
    New-Item -ItemType Directory -Force -Path $outPath
}

if(Test-Path $dlPath) {
    try {
        robocopy $dlPath $outPath /s /xo /r:0 /w:0
    } catch {
        Write-Host -ForegroundColor Red "Could not copy files"
    }
} else {
    Write-Host -ForegroundColor Red "Online share was not available"
    break
}