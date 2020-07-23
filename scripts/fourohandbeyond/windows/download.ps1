Write-Host "Downloading - there is no progress indicator! Please be patient!"

Write-Host "Creating 'install' folder"
New-Item -ItemType Directory -Force -Path install | Out-Null

#Versions
. .\scripts\version.ps1

#Files
$jreZip = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64.zip"
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$gdsZip = "neo4j-graph-data-science-$($gdsVersion)-standalone.zip"
$apocJar = "apoc-$($apocVersion)-all.jar"
#$apocCoreJar = "apoc-$($apocVersion)-core.jar" - alternative for all
$apocNLPJar = "apoc-nlp-dependencies-$($apocVersion).jar"
$apocMongoDBJar = "apoc-mongodb-dependencies-$($apocVersion).jar"

$url = "https://neo4j.com/artifact.php?name=$($neo4jZip)"
$path = Join-Path (Get-Location).Path "install\$($neo4jZip)"
Write-Host "Neo4j to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://cdn.azul.com/zulu/bin/$($jreZip)"
$path = Join-Path (Get-Location).Path "install\$($jreZip)"
Write-Host "JRE to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocJar)"
$path = Join-Path (Get-Location).Path "install\$($apocJar)"
Write-Host "APOC to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

#$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocCoreJar)"
#$path = Join-Path (Get-Location).Path "install\$($apocCoreJar)"
#Write-Host "APOC Core to: " $path
#(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocNLPJar)"
$path = Join-Path (Get-Location).Path "install\$($apocNLPJar)"
Write-Host "APOC NLP Dependencies to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocMongoDBJar)"
$path = Join-Path (Get-Location).Path "install\$($apocMongoDBJar)"
Write-Host "APOC MongoDB Dependencies to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/$($gdsZip)"
$path = Join-Path (Get-Location).Path "install\$($gdsZip)"
Write-Host "GDS to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

Write-Host "All Done!"