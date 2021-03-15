# Version
. .\scripts\version.ps1

# Java Location
$javaJRELocation = Join-Path (Get-Location).Path "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

# Environment
if (Test-Path env:_JAVA_OPTIONS) {
  Remove-Item env:_JAVA_OPTIONS
}
$env:JAVA_HOME = $javaJRELocation
$env:PATH = "$($javaJRELocation)\bin;" + $env:PATH
