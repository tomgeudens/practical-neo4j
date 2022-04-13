param($product="")
$product = $product.ToLower()

# Imports
. .\scripts\version.ps1
. .\scripts\functions.ps1

# Opening statement
Write-Host "Downloading - there is no progress indicator! Please be patient!" -ForegroundColor Cyan

https://dlcdn.apache.org/hop/1.2.0/apache-hop-client-1.2.0.zip
# Files
$jreZip = "OpenJDK$($temurinMajorVersion)U-$($temurinType)_x64_windows_hotspot_$($temurinZipVersion).zip"
$hopZip = "apache-hop-client-$($hopVersion).zip"

https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.14.1%2B1/OpenJDK11U-jre_x64_windows_hotspot_11.0.14.1_1.zip
https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u322-b06/OpenJDK8U-jre_x64_windows_hotspot_8u322b06.zip

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
