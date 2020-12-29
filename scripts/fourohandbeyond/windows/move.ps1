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
$gdsJar = "neo4j-graph-data-science-$($gdsVersion)-standalone.jar"
$apocJar = "apoc-$($apocVersion)-all.jar"
$apocMongoDBJar = "apoc-mongodb-dependencies-$($apocVersion).jar"
$apocNLPJar = "apoc-nlp-dependencies-$($apocVersion).jar"


# Plugins
$plugins = @{}
$plugins.Add('gds', (Get-Location).Path + '\install\' + $gdsJar)
$plugins.Add('apoc', (Get-Location).Path + '\install\' + $apocJar)
$plugins.Add('apocmongodb', (Get-Location).Path + '\install\' + $apocMongoDBJar)
$plugins.Add('apocnlp', (Get-Location).Path + '\install\' + $apocNLPJar)

# Target location for each plugin
$locations = @{}
$locations.Add('gds', (Get-Location).Path + '\neo4j-enterprise-' + $neo4jVersion + '\plugins')
$locations.Add('apoc', (Get-Location).Path + '\neo4j-enterprise-' + $neo4jVersion + '\plugins')
$locations.Add('apocmongodb', (Get-Location).Path + '\neo4j-enterprise-' + $neo4jVersion + '\plugins')
$locations.Add('apocnlp', (Get-Location).Path + '\neo4j-enterprise-' + $neo4jVersion + '\plugins')

# Catalog of products
$catalog = "gds","apoc","apocmongodb","apocnlp"

# Actual move
Foreach ($item in $catalog) {
  # a single product parameter on the commandline overrides the full unpack
  if ($product -eq "" -or $product -eq $item){
    MoveFile $item $plugins[$item] $locations[$item]
  }
}

# All done
Write-Host "`nMoving Complete" -ForegroundColor Green
