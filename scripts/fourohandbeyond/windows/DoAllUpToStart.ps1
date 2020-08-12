param($stage="",$password="trinity")
$stage = $stage.ToLower()

Write-Host "    _   __           __ __  _ " -ForegroundColor Cyan
Write-Host "   / | / /__  ____  / // / (_)" -ForegroundColor Yellow
Write-Host "  /  |/ / _ \/ __ \/ // /_/ / " -ForegroundColor Magenta
Write-Host " / /|  /  __/ /_/ /__  __/ /  " -ForegroundColor Magenta
Write-Host "/_/ |_/\___/\____/  /_/_/ /   " -ForegroundColor Yellow
Write-Host "                     /___/    " -ForegroundColor Cyan

if($stage -eq "" -or $stage -eq "scripts"){
    mkdir scripts -Force > $null
    Write-Host "Downloading Scripts ... "     
    $rootUri = "https://raw.githubusercontent.com/tomgeudens/practical-neo4j/master/scripts/fourohandbeyond/windows/"
    
    Write-Host "`tversion.ps1 ... " -NoNewline
    Invoke-WebRequest -Uri $rootUri"version.ps1"     -OutFile ./scripts/version.ps1
    Write-Host "Done!" -ForegroundColor Green
    
    Write-Host "`tdownload.ps1 ... " -NoNewline
    Invoke-WebRequest -Uri $rootUri"download.ps1"    -OutFile ./scripts/download.ps1
    Write-Host "Done!" -ForegroundColor Green
    
    Write-Host "`tunpack.ps1 ... " -NoNewline
    Invoke-WebRequest -Uri $rootUri"unpack.ps1"      -OutFile ./scripts/unpack.ps1
    Write-Host "Done!" -ForegroundColor Green
    
    Write-Host "`tsettings.ps1 ... " -NoNewline
    Invoke-WebRequest -Uri $rootUri"settings.ps1"    -OutFile ./scripts/settings.ps1
    Write-Host "Done!" -ForegroundColor Green
    
    Write-Host "`tstart.ps1 ... " -NoNewline
    Invoke-WebRequest -Uri $rootUri"start.ps1"       -OutFile ./scripts/start.ps1
    Write-Host "Done!" -ForegroundColor Green
    
    Write-Host "`tenvironment.bat ... " -NoNewline
    Invoke-WebRequest -Uri $rootUri"environment.bat" -OutFile ./scripts/environment.bat
    Write-Host "Done!" -ForegroundColor Green   
    
    Write-Host "`nScripts download complete!" -ForegroundColor Green
}

Write-Host "Setting Execution Policy ... " -NoNewline
Set-ExecutionPolicy Bypass -Scope CurrentUser
Write-Host "Done!" -ForegroundColor Green

if($stage -eq "" -or $stage -eq "download"){
    ./scripts/download.ps1
    Write-Host "`n`nIf you saw any error messages above press " -NoNewLine; Write-Host "CTRL+C" -ForegroundColor Green -NoNewLine; Write-Host " and try to redownload, then run: '.\DoAllUpToStart unpack' to continue."
    Write-Host "To redownload any of the files specifically, run:"
    Write-Host "`t.\scripts\download.ps1 <name>" -ForegroundColor Yellow -NoNewline; Write-Host " where " -NoNewline; Write-Host "<name>" -ForegroundColor Yellow -NoNewline; Write-Host " can be one of: " -NoNewline; Write-Host "neo4j,jre,apoc,apocnlp,apocmongodb,gds" -ForegroundColor Yellow
    Write-Host "`nOtherwise - Press " -NoNewLine; Write-Host "ENTER" -NoNewLine -ForegroundColor Green; Write-Host " to continue.";
    $_ = Read-Host
}

if($stage -eq "" -or $stage -eq "unpack"){
    ./scripts/unpack.ps1
    $stage = ""
}

if($stage -eq "" -or $stage -eq "settings"){
    ./scripts/settings.ps1 -password $password
    $stage = ""
}
