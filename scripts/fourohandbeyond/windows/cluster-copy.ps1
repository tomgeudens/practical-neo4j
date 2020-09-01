param($Instance="",$SizeOfCluster=3)
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

Write-Host "Creating cluster Instance " -NoNewline; Write-Host $Instance -ForegroundColor Cyan -NoNewline; Write-Host " of " -NoNewline; Write-Host $SizeOfCluster -ForegroundColor Cyan

#Versions
. .\scripts\version.ps1

#Directories
$baseNeo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$neo4jDir = "$($baseNeo4jDir)-$($Instance)"

#Install Path
$configFileLocation = Join-Path (Get-Location).Path "$($neo4jDir)\conf\neo4j.conf"

#Copy Instance
New-Item "$neo4jDir" -ItemType "directory" | Out-Null
Copy-Item "$baseNeo4jDir\*" "$neo4jDir\" -Recurse -Force

#Set ports
#These config settings should allow up to a cluster size of 19.
$InstanceInt = ([int]$Instance)
$discovery = 5000 + $InstanceInt
$transaction = 6000 + $InstanceInt
$raft = 7000 + $InstanceInt
$bolt = 7400 + $InstanceInt
$http = 7600 + $InstanceInt
$https = 7800 + $InstanceInt
$backup = 6500 + $InstanceInt

Write-Host "Ports for Cluster Member: " -NoNewline; Write-Host $Instance -ForegroundColor Cyan -NoNewline; Write-Host "/$SizeOfCluster";
Write-Host "-------------------------------------"
Write-Host "`tHTTP       : " -NoNewline; Write-Host $http -ForegroundColor Green
Write-Host "`tBolt       : " -NoNewline; Write-Host $bolt -ForegroundColor Green
Write-Host "`tHTTPS      : " -NoNewline; Write-Host $https -ForegroundColor Green
Write-Host "`tDiscovery  : " -NoNewline; Write-Host $discovery -ForegroundColor Green
Write-Host "`tTransaction: " -NoNewline; Write-Host $transaction -ForegroundColor Green
Write-Host "`tRaft       : " -NoNewline; Write-Host $raft -ForegroundColor Green
Write-Host "`tBackup     : " -NoNewline; Write-Host $backup -ForegroundColor Green

$initialMembers = ""
$initialMembersCount = $SizeOfCluster
if($initialMembersCount -gt 3) {
    $initialMembersCount = 3
}
for ($i = 0; $i -lt $initialMembersCount; $i++) {
    $modifier = ($i + 1)
    $port = 5000 + $modifier
    $initialMembers = $initialMembers + "127.0.0.1:$port,"
}

#Strip the final extra ','
$initialMembers = $initialMembers.Substring(0, $initialMembers.Length - 1)

$configLines = (
    "",
    "#Cluster Config",
    "dbms.mode=CORE",
    "causal_clustering.minimum_core_cluster_size_at_formation=$initialMembersCount",
    "causal_clustering.minimum_core_cluster_size_at_runtime=$initialMembersCount",
    "causal_clustering.initial_discovery_members=$initialMembers",
    "causal_clustering.discovery_listen_address=0.0.0.0:$discovery",
    "causal_clustering.transaction_listen_address=0.0.0.0:$transaction",
    "causal_clustering.raft_listen_address=0.0.0.0:$raft",
    "causal_clustering.discovery_advertised_address=127.0.0.1:$discovery",
    "causal_clustering.transaction_advertised_address=127.0.0.1:$transaction",
    "causal_clustering.raft_advertised_address=127.0.0.1:$raft",
    "",
    "dbms.connector.bolt.enabled=true",
    "dbms.connector.bolt.advertised_address=0.0.0.0:$bolt",
    "dbms.connector.bolt.listen_address=0.0.0.0:$bolt",
    "dbms.connector.http.enabled=true",
    "dbms.connector.http.listen_address=0.0.0.0:$http",
    "dbms.connector.http.advertised_address=0.0.0.0:$http",
    "dbms.connector.https.enabled=false",
    "dbms.connector.https.listen_address=0.0.0.0:$https",
    "dbms.connector.https.advertised_address=0.0.0.0:$https",
    "",
    "dbms.backup.listen_address=0.0.0.0:$backup"
)

Write-Host "Adding config to " $configFileLocation
foreach($line in $configLines) {
    Add-Content -Path $configFileLocation -Value "$($line)"
    Write-Host "`t" $line    
}
Write-Host "Done!" -ForegroundColor Green

Write-Host "`nCreating cluster Instance " -NoNewline; Write-Host $Instance -ForegroundColor Cyan -NoNewline; Write-Host " of " -NoNewline; Write-Host $SizeOfCluster -ForegroundColor Cyan -NoNewline; Write-Host "..." -NoNewline; Write-Host "Done!" -ForegroundColor Green 
Write-Host "This Instance when run will be accessible at:" -NoNewline; Write-Host "http://127.0.0.1:$http" -ForegroundColor Cyan;