Write-Host "Downloading - there is no progress indicator! Please be patient!"

Write-Host "Creating 'install' folder"
New-Item -ItemType Directory -Force -Path install | Out-Null

#Versions
$cypherVersion = "4.1.1"

#Files
$jreZip = "zulu11.39.15-ca-jre11.0.7-win_x64.zip"
$cypherZip = "cypher-shell.zip"

$url = "https://github.com/neo4j/cypher-shell/releases/download/$($cypherVersion)/$($cypherZip)"
$path = Join-Path (Get-Location).Path "install\$($cypherZip)"
Write-Host "Cypher to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://cdn.azul.com/zulu/bin/$($jreZip)"
$path = Join-Path (Get-Location).Path "install\$($jreZip)"
Write-Host "JRE to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

Write-Host "All Done!"
