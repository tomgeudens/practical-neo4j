. .\scripts\version.ps1
. .\scripts\shared-vars.ps1

Write-Host "Setting Java Environment for this session ... " -NoNewline
if (Test-Path env:_JAVA_OPTIONS) {
  Remove-Item env:_JAVA_OPTIONS
}

$env:JAVA_HOME = $javaJRELocation
$env:PATH = "$($javaJRELocation)\bin;" + $env:PATH
$env:NEO4J_ACCEPT_LICENSE_AGREEMENT = "yes"

Write-Host "Done!" -ForegroundColor Green