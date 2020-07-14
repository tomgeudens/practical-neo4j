Write-Host "Unpacking the downloads..."

#Versions
$cypherVersion = "4.1.1"

#Files
$jreZip = "zulu11.39.15-ca-jre11.0.7-win_x64.zip"
$cypherZip = "cypher-shell.zip"

#Install Path
$installPath = Join-Path (Get-Location).Path "install"

#Unzip zipped things
$expandPath = Join-Path $installPath $cypherZip
Expand-Archive -Force $expandPath ".\"
Write-Host "Cypher done ..."

$expandPath = Join-Path $installPath $jreZip
Expand-Archive -Force $expandPath ".\"
Write-Host "JRE done ... "

Write-Host "All done!"
