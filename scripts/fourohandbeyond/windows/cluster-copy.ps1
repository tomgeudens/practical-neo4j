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

Write-Host "Creating cluster instance " -NoNewline; Write-Host $instance -ForegroundColor Cyan -NoNewline; Write-Host " of " -NoNewline; Write-Host $sizeOfCluster -ForegroundColor Cyan

#Versions
. .\scripts\version.ps1

#Directories
$baseNeo4jDir = "neo4j-enterprise-$($neo4jVersion)"
$neo4jDir = "$($baseNeo4jDir)-$($instance)"

#Install Path
$configFileLocation = Join-Path (Get-Location).Path "$($neo4jDir)\conf\neo4j.conf"

#Copy instance
New-Item "$neo4jDir" -ItemType "directory" | Out-Null
Copy-Item "$baseNeo4jDir\*" "$neo4jDir\" -Recurse -Force

#Set ports
#These config settings should allow up to a cluster size of 19.
$instanceInt = ([int]$instance * 10)
$discovery = 5000 + $instanceInt
$transaction = 6000 + $instanceInt
$raft = 7000 + $instanceInt
$bolt = 7400 + $instanceInt
$http = 7600 + $instanceInt
$https = 7800 + $instanceInt
$backup = 6500 + $instanceInt

Write-Host "Ports for Cluster Member: " -NoNewline; Write-Host $instance -ForegroundColor Cyan -NoNewline; Write-Host "/$sizeOfCluster";
Write-Host "-------------------------------------"
Write-Host "`tHTTP       : " -NoNewline; Write-Host $http -ForegroundColor Green
Write-Host "`tBolt       : " -NoNewline; Write-Host $bolt -ForegroundColor Green
Write-Host "`tHTTPS      : " -NoNewline; Write-Host $https -ForegroundColor Green
Write-Host "`tDiscovery  : " -NoNewline; Write-Host $discovery -ForegroundColor Green
Write-Host "`tTransaction: " -NoNewline; Write-Host $transaction -ForegroundColor Green
Write-Host "`tRaft       : " -NoNewline; Write-Host $raft -ForegroundColor Green
Write-Host "`tBackup     : " -NoNewline; Write-Host $backup -ForegroundColor Green

$initialMembers = ""
for ($i = 0; $i -lt $sizeOfCluster; $i++) {
    $modifier = ($i + 1) * 10
    $port = 5000 + $modifier
    $initialMembers = $initialMembers + "127.0.0.1:$port,"
}

#Strip the final extra ','
$initialMembers = $initialMembers.Substring(0, $initialMembers.Length - 1)

$configLines = (
    "",
    "#Cluster Config",
    "dbms.mode=CORE",
    "causal_clustering.minimum_core_cluster_size_at_formation=$sizeOfCluster",
    "causal_clustering.minimum_core_cluster_size_at_runtime=$sizeOfCluster",
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

Write-Host "`nCreating cluster instance " -NoNewline; Write-Host $instance -ForegroundColor Cyan -NoNewline; Write-Host " of " -NoNewline; Write-Host $sizeOfCluster -ForegroundColor Cyan -NoNewline; Write-Host "..." -NoNewline; Write-Host "Done!" -ForegroundColor Green 
Write-Host "This instance when run will be accessible at:" -NoNewline; Write-Host "http://127.0.0.1:$http" -ForegroundColor Cyan;