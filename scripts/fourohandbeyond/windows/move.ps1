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
$apocJar = "apoc-$($apocVersion)-all.jar"
$apocLicense = "license-dependency.json"

# APOC Dependency list
$dependencies = "couchbase","email","mongodb","nlp","xls"

# Plugins
$plugins = @{}
$plugins.Add('gds', (Get-Location).Path + "\install\$($gdsJar)")
$plugins.Add('apoc', (Get-Location).Path + "\install\$($apocJar)")
Foreach ($dependency in $dependencies) {
  $plugins.Add("apoc$($dependency)", (Get-Location).Path + "\install\apoc-$($dependency)-dependencies-$($apocVersion).jar")
}
$plugins.Add('apoclicense', (Get-Location).Path + "\install\$($apocLicense)")

# Target location for each plugin
$locations = @{}
$locations.Add('gds', (Get-Location).Path + "\neo4j-enterprise-$($neo4jVersion)\plugins")
$locations.Add('apoc', (Get-Location).Path + "\neo4j-enterprise-$($neo4jVersion)\plugins")
Foreach ($dependency in $dependencies) {
  $locations.Add("apoc$($dependency)", (Get-Location).Path + "\neo4j-enterprise-$($neo4jVersion)\plugins")
}
$locations.Add('apoclicense', (Get-Location).Path + "\neo4j-enterprise-$($neo4jVersion)\plugins")

# Catalog of products
$catalog = "gds","apoc","apoccouchbase","apocemail","apocmongodb","apocnlp","apocxls","apoclicense"

# Actual move
Foreach ($item in $catalog) {
  # a single product parameter on the commandline overrides the full unpack
  if ($product -eq "" -or $product -eq $item){
    MoveFile $item $plugins[$item] $locations[$item]
  }
}

# All done
Write-Host "`nMoving Complete" -ForegroundColor Green
