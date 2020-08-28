param($instance="",$sizeOfCluster=3)
if($instance -eq "")
{
    Write-Host "No instance was set, this needs to be set!" -ForegroundColor Red
    exit
}

if([int]$instance -gt $sizeOfCluster){
    Write-Host "Instance ID is $instance, but the max size is $sizeOfCluster to run this, you would need to call" -ForegroundColor Red
    Write-Host "`t.\cluster-copy.ps1 $instance $instance" -ForegroundColor Red
    exit
}


#Versions
. .\scripts\version.ps1

$neo4jDir = "neo4j-enterprise-$($neo4jVersion)-$($instance)"
$jreDir = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

#Install Path
$neo4jLocation = Join-Path (Get-Location).Path "$($neo4jDir)"
$javaJRELocation = Join-Path (Get-Location).Path "$($jreDir)"

Write-Host "Setting JAVA_HOME Environment Variable for this session ... " -NoNewline
#Set Java Env Variable for Session
$env:JAVA_HOME = $javaJRELocation
Write-Host "Done!" -ForegroundColor Green

#Import module
Write-Host "Importing Neo4j Modules from " -NoNewline
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Write-Host $neo4jModuleLocation -NoNewline -ForegroundColor Cyan
Import-Module $neo4jModuleLocation -Prefix 'Cluster'
Write-Host " ... Done!" -ForegroundColor Green

Write-Host "Starting Neo4j - " -NoNewline; Write-Host "CTRL+C" -ForegroundColor Cyan -NoNewline; Write-Host  " will exit properly.";
Write-Host "`n`n"
Invoke-ClusterNeo4j Console