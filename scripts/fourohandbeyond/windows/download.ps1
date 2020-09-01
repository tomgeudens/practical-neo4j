param($Product="")
$Product = $Product.ToLower()

function DownloadFile([string] $name, [string] $url, [string] $filename){
    $path = Join-Path (Get-Location).Path "install\$filename"
    Write-Host $name -ForegroundColor Cyan -NoNewLine; Write-Host " to:" $path " ... " -NoNewline;
    try {
        (New-Object System.Net.WebClient).DownloadFile($url, $path)
        Write-Host "Done!" -ForegroundColor Green
    } catch { Write-Host "Failed!" -ForegroundColor Red}
}

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
    $url = "https://neo4j.com/artifact.php?name=$neo4jZip"
    DownloadFile "Neo4j" $url $neo4jZip
}

if($Product -eq "" -or $Product -eq "jre"){
    $url = "https://cdn.azul.com/zulu/bin/$jreZip"
    DownloadFile "JRE" $url $jreZip
}

if($Product -eq "" -or $Product -eq "apoc"){
    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$apocVersion/$apocJar"
    DownloadFile "APOC" $url $apocJar
}

#if($Product -eq "" -or $Product -eq "apoccore"){
#    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$apocVersion/$apocCoreJar"
#    DownloadFile "APOC Core" $url $apocCoreJar
#}

if($Product -eq "" -or $Product -eq "apocnlp"){
    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$apocVersion/$apocNLPJar"
    DownloadFile "APOC NLP Dependencies" $url $apocNLPJar
}
if($Product -eq "" -or $Product -eq "apocmongodb"){
    $url = "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$apocVersion/$apocMongoDBJar"
    DownloadFile "APOC MongoDB Dependencies" $url $apocMongoDBJar
}
if($Product -eq "" -or $Product -eq "gds"){
    $url = "https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/$gdsZip"
    DownloadFile "GDS" $url $gdsZip
}

Write-Host "`nDownloading Complete" -ForegroundColor Green

