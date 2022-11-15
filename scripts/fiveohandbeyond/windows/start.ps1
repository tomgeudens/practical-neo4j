# Opening statement
Write-Host -ForegroundColor Green -BackgroundColor Black "Starting Neo4j!"

#Versions
. .\scripts\version.ps1
. .\scripts\shared-vars.ps1
. .\scripts\set-environment-vars.ps1

Write-Host "Importing Neo4j Modules ... " -NoNewline
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation
Write-Host "Done!" -ForegroundColor Green

# Start
Invoke-Neo4j console