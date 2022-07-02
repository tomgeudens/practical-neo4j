param($product="")
$product = $product.ToLower()

function MoveFile([string] $name, [string] $plugin, [string] $path){
    Write-Host Moving $name -ForegroundColor Cyan -NoNewLine; Write-Host " to:" $path " ... " -NoNewline;
    try {
        Move-Item -Force -Path $plugin -Destination $path
        Write-Host "Done!" -ForegroundColor Green
    } catch { Write-Host "Failed!" -ForegroundColor Red}
}

# Opening statement
Write-Host "Moving the plugins..."

# Version
. .\scripts\version.ps1

# Files
$gdsJar = "neo4j-graph-data-science-$($gdsVersion).jar"

# Plugins
$plugins = @{}
$plugins.Add('gds', (Get-Location).Path + "\install\$($gdsJar)")
$plugins.Add('apoc-core', (Get-Location).Path + "\neo4j-enterprise-$($neo4jVersion)\labs\apoc*core.jar")

# Target location for each plugin
$locations = @{}
$locations.Add('gds', (Get-Location).Path + "\neo4j-enterprise-$($neo4jVersion)\plugins")
$locations.Add('apoc-core', (Get-Location).Path + "\neo4j-enterprise-$($neo4jVersion)\plugins")

# Catalog of products
$catalog = "gds","apoc-core"

# Actual move
Foreach ($item in $catalog) {
  # a single product parameter on the commandline overrides the full unpack
  if ($product -eq "" -or $product -eq $item){
    MoveFile $item $plugins[$item] $locations[$item]
  }
}

# All done
Write-Host "`nMoving Complete" -ForegroundColor Green
