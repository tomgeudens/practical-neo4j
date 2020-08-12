param($password="trinity")

Write-Host "Changing Settings..."

#Versions
. .\scripts\version.ps1

#Directories
$neo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$jreDir = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

#Install Path
$configFileLocation = Join-Path (Get-Location).Path "$($neo4jDir)\conf\neo4j.conf"
$apocFileLocation = Join-Path (Get-Location).Path "$($neo4jDir)\conf\apoc.conf"

#Add all the config you want here, newlines are added later.
$configLines = (
    "metrics.enabled=false",
    "dbms.security.procedures.unrestricted=apoc.*,gds.*",
    "dbms.logs.query.enabled=off",
    "dbms.default_listen_address=0.0.0.0",
    "dbms.memory.heap.initial_size=2048m",
    "dbms.memory.heap.max_size=2048m",
    "dbms.memory.pagecache.size=1g",
    "dbms.tx_log.rotation.retention_policy=1G size"
)
$apocLines = (
    "apoc.export.file.enabled=true",
    "apoc.import.file.enabled=true"
)

Write-Host "Adding config to " $configFileLocation
foreach($line in $configLines) {
    Add-Content -Path $configFileLocation -Value "`r`n$($line)"
    Write-Host "`t *" $line
}
Write-Host "Done!" -ForegroundColor Green

Write-Host "Adding config to " $apocFileLocation
foreach($line in $apocLines) {
    Add-Content -Path $apocFileLocation -Value "`r`n$($line)"
    Write-Host "`t *" $line
}
Write-Host "Done!" -ForegroundColor Green

#Install Path
$neo4jLocation = Join-Path (Get-Location).Path "$($neo4jDir)"
$javaJRELocation = Join-Path (Get-Location).Path "$($jreDir)"

Write-Host "Setting JAVA_HOME Environment Variable for this session ... " -NoNewline
#Set Java Env Variable for Session
$env:JAVA_HOME = $javaJRELocation
Write-Host "Done!" -ForegroundColor Green

#Import module
Write-Host "Importing Neo4j Modules ... " -NoNewline
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation
Write-Host "Done!" -ForegroundColor Green

Write-Host "Setting neo4j initial password ... " -NoNewline
#Set initial password
Invoke-Neo4jAdmin -CommandArgs "set-initial-password $password"
Write-Host "Done!" -ForegroundColor Green

Write-Host "`nSettings Complete" -ForegroundColor Green
