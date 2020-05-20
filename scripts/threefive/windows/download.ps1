Write-Host "Downloading - there is no progress indicator! Please be patient!"

Write-Host "Creating 'install' folder"
New-Item -ItemType Directory -Force -Path install | Out-Null

$neo4jZip = "neo4j-enterprise-3.5.17-windows.zip"
$jdkZip = "zulu8.44.0.11-ca-jdk8.0.242-win_x64.zip"
$gdsZip = "neo4j-graph-data-science-1.1.0-preview-standalone.zip"
$algoZip = "neo4j-graph-algorithms-3.5.14.0-standalone.zip"
$apocVersion = "3.5.0.9"

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


#$url = "https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/neo4j-graph-data-science-1.1.0-preview-standalone.zip"
#$path = Join-Path (Get-Location).Path "install\$($gdsZip)"
#Write-Host "GDS to: " $path
#(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/neo4j-graph-algorithms-3.5.14.0-standalone.zip"
$path = Join-Path (Get-Location).Path "install\$($algoZip)"
Write-Host "ALGO to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)
