param($password="trinity")

# Opening statement
Write-Host "Changing Settings..."

# Version
. .\scripts\version.ps1

# Directories
$neo4jLocation = Join-Path (Get-Location).Path "neo4j-enterprise-$($neo4jVersion)"
$javaJRELocation = Join-Path (Get-Location).Path "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

# Configurationfile
$configFileLocation = Join-Path $neo4jLocation "conf\neo4j.conf"

#Add all the config you want here, newlines are added later.
$configLines = (
    "metrics.enabled=false",
    "dbms.security.procedures.unrestricted=apoc.*,gds.*",
    "dbms.connectors.default_listen_address=0.0.0.0",
    "dbms.memory.heap.initial_size=1024m",
    "dbms.memory.heap.max_size=1024m",
    "dbms.memory.pagecache.size=1g",
    "dbms.udc.enabled=false",
    "dbms.tx_log.rotation.retention_policy=1G size",
    "apoc.export.file.enabled=true",
    "apoc.import.file.enabled=true"
)

Write-Host "Adding config to " $configFileLocation
foreach($line in $configLines) {
    Add-Content -Path $configFileLocation -Value "`r`n$($line)"
    Write-Host "`t *" $line
}
Write-Host "Done!" -ForegroundColor Green

Write-Host "Setting Java Environment for this session ... " -NoNewline
$env:JAVA_HOME = $javaJRELocation
$env:PATH = "$($javaJRELocation)\bin;" + $env:PATH
Write-Host "Done!" -ForegroundColor Green

Write-Host "Importing Neo4j Modules ... " -NoNewline
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation
Write-Host "Done!" -ForegroundColor Green

Write-Host "Setting neo4j initial password ... " -NoNewline
Invoke-Neo4jAdmin set-initial-password $password
Write-Host "Done!" -ForegroundColor Green

# All done
Write-Host "`nSettings Complete" -ForegroundColor Green
