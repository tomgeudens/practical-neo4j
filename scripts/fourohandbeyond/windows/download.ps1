param($product="")
$product = $product.ToLower()

function DownloadFile([string] $name, [string] $url, [string] $path){
    Write-Host $name -ForegroundColor Cyan -NoNewLine; Write-Host " to:" $path " ... " -NoNewline;
    try {
        (New-Object System.Net.WebClient).DownloadFile($url, $path)
        Write-Host "Done!" -ForegroundColor Green
    } catch { Write-Host "Failed!" -ForegroundColor Red}
}

# Opening statement
Write-Host "Downloading - there is no progress indicator! Please be patient!" -ForegroundColor Cyan

# Version
. .\scripts\version.ps1

# Files
$jreZip = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64.zip"
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$gdsZip = "neo4j-graph-data-science-$($gdsVersion)-standalone.zip"
$apocJar = "apoc-$($apocVersion)-all.jar"
$apocLicense = "license-dependency.json"

# APOC Dependency list
$dependencies = "couchbase","email","mongodb","nlp","xls"

# URLs for each product
$urls = @{}
$urls.Add('neo4j',"https://neo4j.com/artifact.php?name=$($neo4jZip)")
$urls.Add('jre',"https://cdn.azul.com/zulu/bin/$($jreZip)")
$urls.Add('gds',"https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/$($gdsZip)")
$urls.Add('apoc',"https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocJar)")
Foreach ($dependency in $dependencies) {
  $urls.Add("apoc$($dependency)","https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/apoc-$($dependency)-dependencies-$($apocVersion).jar")
}
$urls.Add('apoclicense',"https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$($apocVersion)/$($apocLicense)")

# Download location for each product 
$locations = @{}
$locations.Add('neo4j', (Get-Location).Path + "\install\$($neo4jZip)")
$locations.Add('jre', (Get-Location).Path + "\install\$($jreZip)")
$locations.Add('gds', (Get-Location).Path + "\install\$($gdsZip)")
$locations.Add('apoc', (Get-Location).Path + "\install\$($apocJar)")
Foreach ($dependency in $dependencies) {
  $locations.Add("apoc$($dependency)", (Get-Location).Path + "\install\apoc-$($dependency)-dependencies-$($apocVersion).jar")
}
$locations.Add('apoclicense', (Get-Location).Path + "\install\$($apocLicense)")

# Catalog of products
$catalog = "neo4j","jre","gds","apoc","apoccouchbase","apocemail","apocmongodb","apocnlp","apocxls","apoclicense"

# Create install folder
Write-Host "Creating 'install' folder ... " -NoNewline;
New-Item -ItemType Directory -Force -Path install | Out-Null
Write-Host "Done!" -ForegroundColor Green

# Actual download
Foreach ($item in $catalog) {
  # a single product parameter on the commandline overrides the full download
  if ($product -eq "" -or $product -eq $item){
    DownloadFile $item $urls[$item] $locations[$item]
  }
}

# All done
Write-Host "`nDownloading Complete" -ForegroundColor Green
