Write-Host -ForegroundColor Green -BackgroundColor Black "Starting Neo4j!"

#Versions
$neo4jVersion = "4.0.4"

#Directories
$neo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$jdkDir = "zulu11.39.15-ca-jdk11.0.7-win_x64"

#Install Path
$neo4jLocation = Join-Path (Get-Location).Path "$($neo4jDir)"
$javaSdkLocation = Join-Path (Get-Location).Path "$($jdkDir)"

#Set Java Env Variable for Session
$env:JAVA_HOME = $javaSdkLocation

#Import module
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation

#Start!
Invoke-Neo4j Console