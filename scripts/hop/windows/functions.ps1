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
