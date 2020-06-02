Write-Host "Downloading - there is no progress indicator! Please be patient!"

Write-Host "Creating 'install' folder"
New-Item -ItemType Directory -Force -Path install | Out-Null

$neo4jZip = "neo4j-enterprise-4.0.4-windows.zip"
$jdkZip = "zulu11.39.15-ca-jdk11.0.7-win_x64.zip"
$gdsZip = "neo4j-graph-data-science-1.2.1-standalone.zip"
$apocVersion = "4.0.0.12"

$url = "https://neo4j.com/artifact.php?name=$($neo4jZip)"
$path = Join-Path (Get-Location).Path "install\$($neo4jZip)"
Write-Host "Neo4j to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://cdn.azul.com/zulu/bin/$($jdkZip)"
$path = Join-Path (Get-Location).Path "install\$($jdkZip)"
Write-Host "JDK to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$file = "apoc-$($apocVersion)-all.jar"
$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($file)"
$path = Join-Path (Get-Location).Path "install\$($file)"
Write-Host "APOC to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$file = "apoc-nlp-dependencies-$($apocVersion).jar"
$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($file)"
$path = Join-Path (Get-Location).Path "install\$($file)"
Write-Host "APOC NLP Dependencies to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/$($gdsZip)"
$path = Join-Path (Get-Location).Path "install\$($gdsZip)"
Write-Host "GDS to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)
