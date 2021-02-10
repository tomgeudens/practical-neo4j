# Imports
if($null -eq $neo4jVersion){
    . .\scripts\version.ps1
}

# Constants
$neo4jLocation = Join-Path (Get-Location).Path "neo4j-enterprise-$($neo4jVersion)"

function DownloadFileUsingGetFileInfo {
    <#
        .SYNOPSIS 
            Downloads a file 
        
        .PARAMETER GetFileInfo
            An object containing at least 3 properties: 
            * Name - the name of the file to download
            * Uri - the URI (without the Name) of the file
            * Path - The path to download the file to (without the Name)

        .INPUTS
            PsObject
        
        .OUTPUTS
            PSCustomObject
    #>

    param (
        [Parameter(Mandatory)]
        [PsObject] $GetFileInfo
    )

    $uri = "$($GetFileInfo.Uri)/$($GetFileInfo.Name)";
    $path = Join-Path $GetFileInfo.Path $GetFileInfo.Name
    DownloadFile $GetFileInfo.Name $uri $path
}

function DownloadFile
{
    <#
        .SYNOPSIS 
            Downloads a file using the WebClient.

        .DESCRIPTION
            Downloads a file to a given path. This uses the System.Net.WebClient to perform the download which is fast, but also doesn't show any feedback as to the progress being made.
        
        .PARAMETER Name
            The name of the file to download.
        
        .PARAMETER Url
            The URI to download the file from.
        
        .PARAMETER Path
            The path to download the file to.
        
        .EXAMPLE
            DownloadFile -Name 'File.ext' -Url 'https://server.com/file.ext' -Path 'C:\temp\file.ext' 

        .INPUTS
            String
        
        .OUTPUTS
            PSCustomObject
    #>

    param(
        [Parameter(Mandatory)]
        [String]$Name,
        [Parameter(Mandatory)]
        [String]$Uri,
        [Parameter(Mandatory)]
        [String]$Path
    )

    Write-Host "Downloading" $Name -ForegroundColor Cyan -NoNewLine; Write-Host " to:" $Path " ... " -NoNewline;
    try {
        (New-Object System.Net.WebClient).DownloadFile($Uri, $Path)
        Write-Host "Done!" -ForegroundColor Green
    } catch { Write-Host "Failed!" -ForegroundColor Red}
}

function LoadDump { 
    param (
        [Parameter(Mandatory)]
        [PsObject] $dumpInfo
    )
    Write-Host "Loading " -NoNewLine; Write-Host $dumpInfo.Name -ForegroundColor Cyan -NoNewline; Write-Host " to: $($dumpInfo.Database)... ";
    try{
        $ignore = Invoke-Neo4jAdmin load --from="$($dumpInfo.Path)\$($dumpInfo.Name)" --database="$($dumpInfo.Database)" 
        Write-Host "Loading " -NoNewLine; Write-Host $dumpInfo.Name -ForegroundColor Cyan -NoNewline; Write-Host " to: $($dumpInfo.Database)... " -NoNewline; Write-Host "Done!`n" -ForegroundColor Green
    }catch {Write-Host "Failed!"    -ForegroundColor Red}
}

function CreateDumpDatabase { 
    param (
        [Parameter(Mandatory)]
        [PsObject] $dumpInfo
    )
    
    $results = "";
    $isDropping = "";
    Write-Host "Creating Database " -NoNewLine; Write-Host $dumpInfo.Database -ForegroundColor Cyan -NoNewline; Write-Host "..." -NoNewline
    $cypherShell = Join-Path $neo4jLocation "bin\cypher-shell.bat" 
    try {
        $results = . $cypherShell -u neo4j -p $password -d system "CREATE DATABASE $($dumpInfo.Database);" 2>&1
        if($results) {
            Write-Host "`n`tUnexpected result when creating the '$($dumpInfo.Database)' database!!`n`t - '$($results)'" -ForegroundColor Red
            Write-Host "You can drop the database and recreate it if you want. To do so, type '" -NoNewline; Write-Host "DROP" -ForegroundColor Cyan -NoNewline; Write-Host "' below (press ENTER otherwise)."
            $response = Read-Host
            if($response.ToLower() -eq "drop") {
                  $isDropping = "yes"
                  DropDatabase $dumpInfo 
                  CreateDumpDatabase $dumpInfo
            } else {
                $isDropping = "no"
                Write-Host "Creating Database " -NoNewLine; Write-Host $dumpInfo.Database -ForegroundColor Cyan -NoNewline; Write-Host "..." -NoNewline; Write-Host "Skipped" -ForegroundColor DarkYellow
            }
        }
        if(!$isDropping){
            Write-Host "Created" -ForegroundColor Green;
        }
    } catch { Write-Host "Failed!`n" + $_ -ForegroundColor Red }
}

function DropDatabase {    
    param (
        [Parameter(Mandatory)]
        [PsObject] $dumpInfo
    )
    $result = "";
    Write-Host "Dropping Database " -NoNewLine; Write-Host $dumpInfo.Database -ForegroundColor Cyan -NoNewline; Write-Host "..." -NoNewline
    $cypherShell = Join-Path $neo4jLocation "bin\cypher-shell.bat"    
    try{
         $result = . $cypherShell -u neo4j -p $password -d system "DROP DATABASE $($dumpInfo.Database);"
         if($result){
             Write-Host "`n`tUnexpected result when dropping the '$($dumpInfo.Database)' database!!`n`t - '$($result)'" -ForegroundColor Red
         }
         Write-Host "Dropped" -ForegroundColor Green;
    }catch {Write-Host "Failed!`n" + $_ -ForegroundColor Red}
}

function ValidateLoading {
    param (
        [Parameter(Mandatory)]
        [PsObject] $dumpInfo
    )
    Write-Host "Verifying Database " -NoNewLine; Write-Host $dumpInfo.Database -ForegroundColor Cyan -NoNewline; Write-Host "..." -NoNewline
    $cypherShell = Join-Path $neo4jLocation "bin\cypher-shell.bat"    
    try{
         $result = . $cypherShell -u neo4j -p $password -d $dumpInfo.Database "MATCH () RETURN count(*) AS actual;"
         if($result[1] -eq $dumpInfo.ExpectedNodes){
            Write-Host "Verified" -ForegroundColor Green -NoNewline; Write-Host " found $($result[1]) nodes.";
         } else {
            Write-Host "Unexpected number of Nodes, expected $($dumpInfo.ExpectedNodes) but got: $($result[1])" -ForegroundColor Red
         }
    }catch {Write-Host "Failed!`n" + $_ -ForegroundColor Red}
}