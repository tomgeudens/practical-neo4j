param($Product="")
$Product = $Product.ToLower()

Write-Host "Downloading - there is no progress indicator! Please be patient!" -ForegroundColor Cyan
Write-Host "Creating 'install' folder ... " -NoNewline;
New-Item -ItemType Directory -Force -Path install | Out-Null
Write-Host "Done!" -ForegroundColor Green

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

if($Product -eq "" -or $Product -eq "neo4j"){
    $url = "https://neo4j.com/artifact.php?name=$($neo4jZip)"
    $path = Join-Path (Get-Location).Path "install\$($neo4jZip)"
    Write-Host "Neo4j" -ForegroundColor Cyan -NoNewLine; Write-Host " to: " $path " ... " -NoNewline;
    (New-Object System.Net.WebClient).DownloadFile($url, $path)
    Write-Host "Done!" -ForegroundColor Green
}

if($Product -eq "" -or $Product -eq "jre"){
    $url = "https://cdn.azul.com/zulu/bin/$($jreZip)"
    $path = Join-Path (Get-Location).Path "install\$($jreZip)"
    Write-Host "JRE" -ForegroundColor Cyan -NoNewLine; Write-Host " to: " $path " ... " -NoNewline;
    (New-Object System.Net.WebClient).DownloadFile($url, $path)
    Write-Host "Done!" -ForegroundColor Green
}

if($Product -eq "" -or $Product -eq "apoc"){
    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocJar)"
    $path = Join-Path (Get-Location).Path "install\$($apocJar)"
    Write-Host "APOC" -ForegroundColor Cyan -NoNewLine; Write-Host " to: " $path " ... " -NoNewline;
    (New-Object System.Net.WebClient).DownloadFile($url, $path)
    Write-Host "Done!" -ForegroundColor Green
}

#if($Product -eq "" -or $Product -eq "apoccore"){
#    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocCoreJar)"
#    $path = Join-Path (Get-Location).Path "install\$($apocCoreJar)"
#    Write-Host "APOC Core to: " $path " ... " -NoNewline;
#    (New-Object System.Net.WebClient).DownloadFile($url, $path)
#    Write-Host "Done!" -ForegroundColor Green
#}

if($Product -eq "" -or $Product -eq "apocnlp"){
    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocNLPJar)"
    $path = Join-Path (Get-Location).Path "install\$($apocNLPJar)"
    Write-Host "APOC NLP Dependencies" -ForegroundColor Cyan -NoNewLine; Write-Host " to: " $path " ... " -NoNewline;
    (New-Object System.Net.WebClient).DownloadFile($url, $path)
    Write-Host "Done!" -ForegroundColor Green
}
if($Product -eq "" -or $Product -eq "apocmongodb"){
    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocMongoDBJar)"
    $path = Join-Path (Get-Location).Path "install\$($apocMongoDBJar)"
    Write-Host "APOC MongoDB Dependencies" -ForegroundColor Cyan -NoNewLine; Write-Host " to: " $path " ... " -NoNewline;
    (New-Object System.Net.WebClient).DownloadFile($url, $path)
    Write-Host "Done!" -ForegroundColor Green
}
if($Product -eq "" -or $Product -eq "gds"){
    $url = "https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/$($gdsZip)"
    $path = Join-Path (Get-Location).Path "install\$($gdsZip)"
    Write-Host "GDS" -ForegroundColor Cyan -NoNewLine; Write-Host " to: " $path " ... " -NoNewline;
    (New-Object System.Net.WebClient).DownloadFile($url, $path)
    Write-Host "Done!" -ForegroundColor Green
}

Write-Host "`nDownloading Complete" -ForegroundColor Green