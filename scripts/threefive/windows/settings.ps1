Write-Host "Changing Settings..."

#Versions
. .\scripts\version.ps1

#Directories
$neo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$jreDir = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

#Install Path
$configFileLocation = Join-Path (Get-Location).Path "$($neo4jDir)\conf\neo4j.conf"

#Add all the config you want here, newlines are added later.
$configLines = (
    "metrics.enabled=false",
    "dbms.security.procedures.unrestricted=apoc.*,gds.*",
    "dbms.connectors.default_listen_address=0.0.0.0",
    "dbms.memory.heap.initial_size=1024m",
    "dbms.memory.heap.max_size=1024m",
    "dbms.memory.pagecache.size=1g",
    "dbms.udc.enabled=false",
    "dbms.tx_log.rotation.retention_policy=1G size"
)

Write-Host "Adding config to " $configFileLocation
foreach($line in $configLines) {
    Add-Content -Path $configFileLocation -Value "`r`n$($line)"
    Write-Host "`t *" $line
}

#Install Path
$neo4jLocation = Join-Path (Get-Location).Path "$($neo4jDir)"
$javaJRELocation = Join-Path (Get-Location).Path "$($jreDir)"

#Set Java Env Variable for Session
$env:JAVA_HOME = $javaJRELocation

#Import module
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation

#Set initial password
Invoke-Neo4jAdmin -CommandArgs "set-initial-password trinity"

Write-Host "All Done!"
