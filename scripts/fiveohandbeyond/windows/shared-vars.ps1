$jreZip = "OpenJDK$($javaVersion)U-jre_x64_windows_hotspot_$($temurinFileVersion).zip"
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"

$neo4jLocation = Join-Path (Get-Location).Path "neo4j-enterprise-$($neo4jVersion)"
$javaJRELocation = Join-Path (Get-Location).Path "jdk-$($temurinHomeVersion)-jre"