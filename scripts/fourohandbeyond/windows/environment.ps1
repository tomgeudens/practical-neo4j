# Version
. .\scripts\version.ps1

# Java Location
$javaJRELocation = Join-Path (Get-Location).Path "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

# Environment
$env:JAVA_HOME = $javaJRELocation
$env:PATH = "$($javaJRELocation)\bin;" + $env:PATH