param($product="")
$product = $product.ToLower()

function UnpackFile([string] $name, [string] $archive, [string] $path){
    Write-Host Unpacking $name -ForegroundColor Cyan -NoNewLine; Write-Host " to:" $path " ... " -NoNewline;
    try {
        Expand-Archive $archive $path
        Write-Host "Done!" -ForegroundColor Green
    } catch { Write-Host "Failed!" -ForegroundColor Red}
}

# Opening statement
Write-Host "Unpacking the downloads..."

# Version
. .\scripts\version.ps1

# Files
$jreZip = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64.zip"
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$gdsZip = "neo4j-graph-data-science-$($gdsVersion).zip"

# Archive for each product
$archives = @{}
$archives.Add('neo4j', (Get-Location).Path + "\install\$($neo4jZip)")
$archives.Add('jre', (Get-Location).Path + "\install\$($jreZip)")
$archives.Add('gds', (Get-Location).Path + "\install\$($gdsZip)")

# Target location for each product 
$locations = @{}
$locations.Add('neo4j', (Get-Location).Path + '\')
$locations.Add('jre', (Get-Location).Path + '\')
$locations.Add('gds', (Get-Location).Path + '\install')

# Catalog of products
$catalog = "neo4j","jre","gds"

# Actual unpack
Foreach ($item in $catalog) {
  # a single product parameter on the commandline overrides the full unpack
  if ($product -eq "" -or $product -eq $item){
    UnpackFile $item $archives[$item] $locations[$item]
  }
}

# All done
Write-Host "`nUnpacking Complete" -ForegroundColor Green
