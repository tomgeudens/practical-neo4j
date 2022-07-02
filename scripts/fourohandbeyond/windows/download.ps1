param($product="")
$product = $product.ToLower()

# Imports
. .\scripts\version.ps1
. .\scripts\functions.ps1

# Opening statement
Write-Host "Downloading - there is no progress indicator! Please be patient!" -ForegroundColor Cyan

# Files
$jreZip = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64.zip"
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$gdsZip = "neo4j-graph-data-science-$($gdsVersion).zip"

# URLs for each product
$urls = @{}
$urls.Add('neo4j',"https://neo4j.com/artifact.php?name=$($neo4jZip)")
$urls.Add('jre',"https://cdn.azul.com/zulu/bin/$($jreZip)")
$urls.Add('gds',"https://graphdatascience.ninja/$($gdsZip)")

# Download location for each product 
$locations = @{}
$locations.Add('neo4j', (Get-Location).Path + "\install\$($neo4jZip)")
$locations.Add('jre', (Get-Location).Path + "\install\$($jreZip)")
$locations.Add('gds', (Get-Location).Path + "\install\$($gdsZip)")

# Catalog of products
$catalog = "neo4j","jre","gds"

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
