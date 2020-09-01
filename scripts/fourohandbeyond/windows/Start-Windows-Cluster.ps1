param($SizeOfCluster=3)

#We do this to copy with those who run pwsh.exe vs Powershell.exe
$process = Get-Process -Id $PID | Select-Object -ExpandProperty ProcessName 

for ($i = 0; $i -lt $SizeOfCluster; $i++) {
    $instance = $i + 1
    Write-Host "Starting cluster instance " -NoNewline; Write-Host $instance -ForegroundColor Cyan -NoNewline; Write-Host " of " -NoNewline; Write-Host $SizeOfCluster -ForegroundColor Cyan
    Start-Process $process -ArgumentList "-command .\scripts\start-cluster-instance.ps1 $instance $SizeOfCluster"
}