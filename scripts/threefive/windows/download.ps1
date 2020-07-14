Write-Host "Downloading - there is no progress indicator! Please be patient!"

Write-Host "Creating 'install' folder"
New-Item -ItemType Directory -Force -Path install | Out-Null

#Versions
$apocVersion = "3.5.0.12"
$neo4jVersion = "3.5.20"
$gdsVersion = "1.1.3"

$jreZip = "zulu8.46.0.19-ca-jre8.0.252-win_x64.zip"
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$gdsZip = "neo4j-graph-data-science-$($gdsVersion)-standalone.zip"
$apocJar = "apoc-$($apocVersion)-all.jar"
#$apocNLPJar = "apoc-nlp-dependencies-$($apocVersion).jar" - 3.5 does not have this ???
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

#$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocNLPJar)"
#$path = Join-Path (Get-Location).Path "install\$($apocNLPJar)"
#Write-Host "APOC NLP Dependencies to: " $path
#(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocMongoDBJar)"
$path = Join-Path (Get-Location).Path "install\$($apocMongoDBJar)"
Write-Host "APOC MongoDB Dependencies to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

$url = "https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/$($gdsZip)"
$path = Join-Path (Get-Location).Path "install\$($gdsZip)"
Write-Host "GDS to: " $path
(New-Object System.Net.WebClient).DownloadFile($url, $path)

Write-Host "All Done!"
