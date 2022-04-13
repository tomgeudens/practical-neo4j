param($product="")
$product = $product.ToLower()

# Functions
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
$jreZip = "OpenJDK$($temurinMajorVersion)U-$($temurinType)_x64_windows_hotspot_$($temurinZipVersion).zip"
$hopZip = "apache-hop-client-$($hopVersion).zip"

# Archive for each product
$archives = @{}
$archives.Add('hop', (Get-Location).Path + "\install\$($neo4jZip)")
$archives.Add('jre', (Get-Location).Path + "\install\$($jreZip)")

# Target location for each product 
$locations = @{}
$locations.Add('hop', (Get-Location).Path + '\')
$locations.Add('jre', (Get-Location).Path + '\')

# Catalog of products
$catalog = "hop","jre"

# Actual unpack
Foreach ($item in $catalog) {
  # a single product parameter on the commandline overrides the full unpack
  if ($product -eq "" -or $product -eq $item){
    UnpackFile $item $archives[$item] $locations[$item]
  }
}

# All done
Write-Host "`nUnpacking Complete" -ForegroundColor Green
