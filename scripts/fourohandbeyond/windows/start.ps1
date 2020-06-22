Write-Host -ForegroundColor Green -BackgroundColor Black "Starting Neo4j!"

#Versions
$apocVersion = "4.0.0.15"
$neo4jVersion = "4.0.6"
$gdsVersion = "1.2.2"

#Directories
$neo4jDir = "neo4j-enterprise-$($neo4jVersion)"
#$jdkDir = "zulu11.39.15-ca-jdk11.0.7-win_x64" - jre does the job really
$jreDir = "zulu11.39.15-ca-jre11.0.7-win_x64"

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
