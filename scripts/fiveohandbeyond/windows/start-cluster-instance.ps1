param($Instance="",$SizeOfCluster=3)
#Versions
. .\scripts\version.ps1
. .\scripts\shared-vars.ps1
. .\scripts\set-environment-vars.ps1

$neo4jDir = "neo4j-enterprise-$($neo4jVersion)-$($Instance)"
$neo4jLocation = Join-Path (Get-Location).Path "$($neo4jDir)"

if($Instance -eq "")
{
    Write-Host "No Instance was set, this needs to be set!" -ForegroundColor Red
    exit
}

if([int]$Instance -gt $SizeOfCluster){
    Write-Host "Instance ID is $Instance, but the max size is $SizeOfCluster to run this, you would need to call" -ForegroundColor Red
    Write-Host "`t.\cluster-copy.ps1 $Instance $Instance" -ForegroundColor Red
    exit
}



#Import module
Write-Host "Importing Neo4j Modules from " -NoNewline
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Write-Host $neo4jModuleLocation -NoNewline -ForegroundColor Cyan
Import-Module $neo4jModuleLocation -Prefix 'Cluster'
Write-Host " ... Done!" -ForegroundColor Green
Write-Host "`nThis is instance " -NoNewline; Write-Host $Instance -ForegroundColor Cyan -NoNewline; Write-Host " of " -NoNewline; Write-Host $SizeOfCluster -ForegroundColor Cyan;
Write-Host "`nStarting Neo4j - " -NoNewline; Write-Host "CTRL+C" -ForegroundColor Cyan -NoNewline; Write-Host  " will exit properly.";
Write-Host "`n`n"
Invoke-ClusterNeo4j console