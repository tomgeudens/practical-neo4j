param($Dump="", $Password="trinity")
$Dump = $Dump.ToLower()

# Imports
. .\scripts\functions.ps1

# Constants
$rootUri = "https://github.com/tomgeudens/practical-neo4j/raw/master/data"

# Opening statement
Write-Host "When downloading the dumps - there is no progress indicator! Please be patient!" -ForegroundColor Cyan

# Setup the Dumps to get, add new ones to the end of the list
$toGet = @()

# Game of Thrones Dataset
$toGet += [PsCustomObject] @{
    Id = 'got' # This is the Identifier used to download specific versions - i.e. if you only want the Game Of Thrones dataset - you can use 'DownloadDumps.ps1 -dump got'
    Name = "gds_gameofthrones.dump" # Name of the dump file
    Uri = $rooturi # The root URI, this is set at the top of the file
    Path = (Get-Location).Path + '\dump\' # Default location to store dump files
    Database = "gameofthrones" # The name of the database to associate with the dump file
    ExpectedNodes = 2642 # The expected number of Nodes in the database
}

# Paysim Dataset
$toGet += [PsCustomObject] @{
    Id = "paysim"
    Name = "gds_paysim.dump"
    Uri = $rooturi
    Path = (Get-Location).Path + '\dump\'
    Database = "paysim"
    ExpectedNodes = 332948
}

# Create install folder
Write-Host "Creating 'dump' folder ... " -NoNewline;
mkdir dump -Force | Out-Null
Write-Host "Done!" -ForegroundColor Green

# Download, Load and Check each dump
foreach ($item in $toGet) {
    if($Dump -eq "" -or -$Dump -eq $item.Id) {
        DownloadFileUsingGetFileInfo $item
        LoadDump $item
        CreateDumpDatabase $item
        ValidateLoading $item
    }
}

# All done
Write-Host "`nDownloading Dumps Complete" -ForegroundColor Green
