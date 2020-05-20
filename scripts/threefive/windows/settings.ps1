Write-Host "Changing Settings..."

#Versions
$neo4jVersion = "3.5.17"

#Directories
$neo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$jdkDir = "zulu8.44.0.11-ca-jdk8.0.242-win_x64"

#Install Path
$configFileLocation = Join-Path (Get-Location).Path "$($neo4jDir)\conf\neo4j.conf"

#Add all the config you want here, newlines are added later.
$configLines = (
    "metrics.enabled=false",
    "dbms.security.procedures.unrestricted=apoc.*,algo.*",
    "dbms.connectors.default_listen_address=0.0.0.0",
    "dbms.memory.heap.initial_size=512m",
    "dbms.memory.heap.max_size=512m",
    "dbms.memory.pagecache.size=1g",
    "dbms.tx_log.rotation.retention_policy=1G size"
)

Write-Host "Adding config to " $configFileLocation
foreach($line in $configLines) {
    Add-Content -Path $configFileLocation -Value "`r`n$($line)"
    Write-Host "`t *" $line
}

#Install Path
$neo4jLocation = Join-Path (Get-Location).Path "$($neo4jDir)"
$javaSdkLocation = Join-Path (Get-Location).Path "$($jdkDir)"

#Set Java Env Variable for Session
$env:JAVA_HOME = $javaSdkLocation

#Import module
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation

#Set initial password
Invoke-Neo4jAdmin -CommandArgs "set-initial-password trinity"
