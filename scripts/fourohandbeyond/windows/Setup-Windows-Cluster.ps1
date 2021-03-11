param($Stage="",$Password="trinity",$SizeOfCluster=3,$Start="false")
$Stage = $Stage.ToLower()
$Start = $Start.ToLower()

Write-Host "    _   __           __ __  _ " -ForegroundColor Cyan
Write-Host "   / | / /__  ____  / // / (_)" -ForegroundColor Yellow
Write-Host "  /  |/ / _ \/ __ \/ // /_/ / " -ForegroundColor Magenta
Write-Host " / /|  /  __/ /_/ /__  __/ /  " -ForegroundColor Magenta
Write-Host "/_/ |_/\___/\____/  /_/_/ /   " -ForegroundColor Yellow
Write-Host "                     /___/    " -ForegroundColor Cyan
Write-Host "                              "
Write-Host "        CLUSTER EDITION       " -ForegroundColor DarkRed -BackgroundColor Yellow -NoNewline; 
Write-Host "`n";

if($Stage -eq "" -or $Stage -eq "scripts"){
    mkdir scripts -Force > $null
    Write-Host "Downloading Scripts ... "     
    $rootUri = "https://raw.githubusercontent.com/tomgeudens/practical-neo4j/master/scripts/fourohandbeyond/windows/"

    #Scripts we want in the 'scripts' folder
    $scriptNames = (
        "version.ps1",
        "download.ps1",
        "unpack.ps1",
        "settings.ps1",
        "start.ps1",
        "move.ps1",
        "environment.ps1",
        "start-cluster-instance.ps1",
        "cluster-copy.ps1",
        "Start-Windows-Cluster.ps1",
        "functions.ps1"
        );
  
    foreach($script in $scriptNames) {
        Write-Host "`t$script ... " -NoNewline
        try{        
            Invoke-WebRequest -Uri $rootUri$script -OutFile ./scripts/$script
            Write-Host "Done!" -ForegroundColor Green
        }
        catch{
            Write-Host "Failed!" -ForegroundColor Red
        }
    }
   
    Write-Host "`nScripts download complete!" -ForegroundColor Green
}

Write-Host "Setting Execution Policy ... " -NoNewline
Set-ExecutionPolicy Bypass -Scope CurrentUser
Write-Host "Done!" -ForegroundColor Green

if($Stage -eq "" -or $Stage -eq "download"){
    ./scripts/download.ps1
    Write-Host "`n`nIf you saw any error messages above press " -NoNewLine; Write-Host "CTRL+C" -ForegroundColor Green -NoNewLine; Write-Host " and try to redownload, then run: '.\Setup-Windows-Cluster.ps1 -Stage unpack' to continue."
    Write-Host "To redownload any of the files specifically, run:"
    Write-Host "`t.\scripts\download.ps1 <name>" -ForegroundColor Yellow -NoNewline; Write-Host " where " -NoNewline; Write-Host "<name>" -ForegroundColor Yellow -NoNewline; Write-Host " can be one of: " -NoNewline; Write-Host "neo4j,jre,apoc,apocnlp,apocmongodb,gds" -ForegroundColor Yellow
    Write-Host "`nOtherwise - Press " -NoNewLine; Write-Host "ENTER" -NoNewLine -ForegroundColor Green; Write-Host " to continue.";
    $_ = Read-Host
}

if($Stage -eq "" -or $Stage -eq "unpack"){
    ./scripts/unpack.ps1
    $Stage = ""
}

if($Stage -eq "" -or $Stage -eq "move"){
    ./scripts/move.ps1
    $Stage = ""
}

if($Stage -eq "" -or $Stage -eq "settings"){
    $process = Get-Process -Id $PID | Select-Object -ExpandProperty ProcessName 
    Write-Host "Launching 'settings' in a new process, the script will continue once that has finished ... " -NoNewline
    Start-Process $process -ArgumentList "-command ./scripts/settings.ps1 -Password $Password" -Wait
    Write-Host "Done!" -ForegroundColor Green
    $Stage = ""
}

if($Stage -eq "" -or $Stage -eq "cluster"){
    for ($i = 0; $i -lt $SizeOfCluster; $i++) {
        ./scripts/cluster-copy.ps1 ($i + 1) $SizeOfCluster
    }
}

if($Start -eq "true"){
    ./scripts/Start-Windows-Cluster.ps1 $SizeOfCluster
}