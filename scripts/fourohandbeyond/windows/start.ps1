Write-Host -ForegroundColor Green -BackgroundColor Black "Starting Neo4j!"

#Versions
$apocVersion = "4.1.0.1"
$neo4jVersion = "4.1.1"
$gdsVersion = "1.3.0"
$zuluVersion = "11.41.23"
$jreVersion = "11.0.8"

#Directories
$neo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$jreDir = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

#Install Path
$neo4jLocation = Join-Path (Get-Location).Path "$($neo4jDir)"
$javaJRELocation = Join-Path (Get-Location).Path "$($jreDir)"

#Set Java Env Variable for Session
$env:JAVA_HOME = $javaJRELocation

#Import module
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation

#Start!
Invoke-Neo4j Console
