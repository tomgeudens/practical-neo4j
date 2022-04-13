param($product="")
$product = $product.ToLower()

# Functions
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


# Imports
. .\scripts\version.ps1

# Opening statement
Write-Host "Downloading - there is no progress indicator! Please be patient!" -ForegroundColor Cyan

# Files
$jreZip = "OpenJDK$($temurinMajorVersion)U-$($temurinType)_x64_windows_hotspot_$($temurinZipVersion).zip"
$hopZip = "apache-hop-client-$($hopVersion).zip"

# URLs for each product
$urls = @{}
$urls.Add('hop',"https://dlcdn.apache.org/hop/$($hopVersion)/$($hopZip)")
$urls.Add('jre',"https://github.com/adoptium/temurin$($temurinMajorVersion)-binaries/releases/download/jdk$($temurinFolderVersion)/$($jreZip)")

# Download location for each product 
$locations = @{}
$locations.Add('hop', (Get-Location).Path + "\install\$($hopZip)")
$locations.Add('jre', (Get-Location).Path + "\install\$($jreZip)")

# Catalog of products
$catalog = "hop","jre"

# Create install folder
Write-Host "Creating 'install' folder ... " -NoNewline;
New-Item -ItemType Directory -Force -Path install | Out-Null
Write-Host "Done!" -ForegroundColor Green

# Actual download
Foreach ($item in $catalog) {
  # a single product parameter on the commandline overrides the full download
  if ($product -eq "" -or $product -eq $item){
    DownloadFile $item $urls[$item] $locations[$item]
  }
}

# All done
Write-Host "`nDownloading Complete" -ForegroundColor Green
