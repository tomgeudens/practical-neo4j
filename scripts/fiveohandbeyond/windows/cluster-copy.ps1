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
$routing = 7450 + $InstanceInt
$mode = "PRIMARY"

if($InstanceInt -gt 10)
{
    $mode = "SECONDARY"
}

Write-Host "Ports for Cluster Member: " -NoNewline; Write-Host $Instance -ForegroundColor Cyan -NoNewline; Write-Host "/$SizeOfCluster" -ForegroundColor Cyan;
Write-Host "-------------------------------------"
Write-Host "`tHTTP        : " -NoNewline; Write-Host $http -ForegroundColor Green
Write-Host "`tBolt        : " -NoNewline; Write-Host $bolt -ForegroundColor Green
Write-Host "`tBolt Routing: " -NoNewline; Write-Host $routing -ForegroundColor Green
Write-Host "`tHTTPS       : " -NoNewline; Write-Host $https -ForegroundColor Green
Write-Host "`tDiscovery   : " -NoNewline; Write-Host $discovery -ForegroundColor Green
Write-Host "`tTransaction : " -NoNewline; Write-Host $transaction -ForegroundColor Green
Write-Host "`tRaft        : " -NoNewline; Write-Host $raft -ForegroundColor Green
Write-Host "`tBackup      : " -NoNewline; Write-Host $backup -ForegroundColor Green

Write-Host "Cluster information: " -NoNewline; Write-Host $Instance -ForegroundColor Cyan -NoNewline; Write-Host "/$SizeOfCluster" -ForegroundColor Cyan;
Write-Host "-------------------------------------"
Write-Host "`tMode        : " -NoNewline; Write-Host $mode -ForegroundColor Green


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
    "server.cluster.system_database_mode=$mode",
    "dbms.cluster.minimum_initial_system_primaries_count=$initialMembersCount",
    "dbms.cluster.discovery.endpoints=$initialMembers",
    "server.discovery.listen_address=127.0.0.1:$discovery",
    "server.cluster.listen_address=127.0.0.1:$transaction",
    "server.cluster.raft.listen_address=127.0.0.1:$raft",
    "server.routing.listen_address=127.0.0.1:$routing",
    "server.discovery.advertised_address=127.0.0.1:$discovery",
    "server.cluster.advertised_address=127.0.0.1:$transaction",
    "server.cluster.raft.advertised_address=127.0.0.1:$raft",
    "server.routing.advertised_address=127.0.0.1:$routing",
    "",
    "server.bolt.enabled=true",
    "server.bolt.advertised_address=127.0.0.1:$bolt",
    "server.bolt.listen_address=127.0.0.1:$bolt",
    "server.http.enabled=true",
    "server.http.listen_address=127.0.0.1:$http",
    "server.http.advertised_address=127.0.0.1:$http",
    "server.https.enabled=false",
    "server.https.listen_address=127.0.0.1:$https",
    "server.https.advertised_address=127.0.0.1:$https",
    "",
    "dbms.backup.listen_address=127.0.0.1:$backup"
)

Write-Host "Adding config to " $configFileLocation
foreach($line in $configLines) {
    Add-Content -Path $configFileLocation -Value "$($line)"
    Write-Host "`t" $line    
}
Write-Host "Done!" -ForegroundColor Green

Write-Host "`nCreating cluster Instance " -NoNewline; Write-Host $Instance -ForegroundColor Cyan -NoNewline; Write-Host " of " -NoNewline; Write-Host $SizeOfCluster -ForegroundColor Cyan -NoNewline; Write-Host "..." -NoNewline; Write-Host "Done!" -ForegroundColor Green 
Write-Host "This Instance when run will be accessible at:" -NoNewline; Write-Host "http://127.0.0.1:$http" -ForegroundColor Cyan;