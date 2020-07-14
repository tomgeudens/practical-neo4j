Write-Host -ForegroundColor Green -BackgroundColor Black "Starting Neo4j!"

#Versions
$apocVersion = "3.5.0.12"
$neo4jVersion = "3.5.20"
$gdsVersion = "1.1.3"

#Directories
$neo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$jreDir = "zulu8.46.0.19-ca-jre8.0.252-win_x64"

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
