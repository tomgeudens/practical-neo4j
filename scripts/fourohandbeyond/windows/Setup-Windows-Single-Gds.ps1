param($Stage="",$Password="trinity",$Start="false")
$Stage = $Stage.ToLower()

Write-Host "    _   __           __ __  _ " -ForegroundColor Cyan
Write-Host "   / | / /__  ____  / // / (_)" -ForegroundColor Yellow
Write-Host "  /  |/ / _ \/ __ \/ // /_/ / " -ForegroundColor Magenta
Write-Host " / /|  /  __/ /_/ /__  __/ /  " -ForegroundColor Magenta
Write-Host "/_/ |_/\___/\____/  /_/_/ /   " -ForegroundColor Yellow
Write-Host "                     /___/    " -ForegroundColor Cyan
Write-Host "                              "
Write-Host "       SINGLE INSTANCE        " -ForegroundColor DarkRed -BackgroundColor Yellow; 
Write-Host "         GDS EDITION          " -ForegroundColor DarkRed -BackgroundColor Yellow -NoNewline; 
Write-Host "`n";

if($Stage -eq "" -or $Stage -eq "scripts"){
    mkdir scripts -Force > $null
    Write-Host "Downloading Scripts ... "     
    $rootUri = "https://raw.githubusercontent.com/tomgeudens/practical-neo4j/master/scripts/fourohandbeyond/windows/"

    #Scripts we want in the 'scripts' folder
    $scriptNames = (
        "version.ps1",
        "download.ps1",
        "downloadDumps.ps1",
        "unpack.ps1",
        "settings.ps1",
        "start.ps1",
        "environment.ps1",
        "move.ps1",
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
    Write-Host "`n`nIf you saw any error messages above press " -NoNewLine; Write-Host "CTRL+C" -ForegroundColor Green -NoNewLine; Write-Host " and try to redownload, then run: '.\Setup-Windows-Single-Gds.ps1 -Stage unpack' to continue."
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
    ./scripts/settings.ps1 -Password $Password
    $Stage = ""
}

Write-Host "Starting Neo4j in a new Window... (Required to load the dumps)"
$process = Get-Process -Id $PID | Select-Object -ExpandProperty ProcessName 
Start-Process $process -ArgumentList "-command .\scripts\start.ps1"
Write-Host "`nPlease wait for Neo4j to say 'Started' then press " -NoNewLine; Write-Host "ENTER" -NoNewLine -ForegroundColor Green; Write-Host " to continue.";
$_ = Read-Host

if($Stage -eq "" -or $Stage -eq "dumps"){
    ./scripts/downloadDumps.ps1 -password $Password
    Write-Host "`n`nIf you saw any error messages above press " -NoNewLine; Write-Host "CTRL+C" -ForegroundColor Green -NoNewLine; Write-Host " and try to redownload."
    Write-Host "To redownload any of the files specifically, run:"
    Write-Host "`t.\scripts\downloadDumps.ps1 <name>" -ForegroundColor Yellow -NoNewline; Write-Host " where " -NoNewline; Write-Host "<name>" -ForegroundColor Yellow -NoNewline; Write-Host " can be one of: " -NoNewline; Write-Host "got,paysim" -ForegroundColor Yellow
    Write-Host "`nOtherwise - Press " -NoNewLine; Write-Host "ENTER" -NoNewLine -ForegroundColor Green; Write-Host " to continue.";
    $_ = Read-Host
}

Write-Host "GDS Setup is complete. You can stop your Neo4j instance now if you want. Or get GDSing!!"