# Version
. .\scripts\version.ps1

# Java Location
$javaJRELocation = Join-Path (Get-Location).Path "jdk-$($temurinHomeVersion)-jre"

# Environment
if (Test-Path env:_JAVA_OPTIONS) {
  Remove-Item env:_JAVA_OPTIONS
}
$env:JAVA_HOME = $javaJRELocation
$env:PATH = "$($javaJRELocation)\bin;" + $env:PATH
$env:NEO4J_ACCEPT_LICENSE_AGREEMENT = "yes"
