Write-Host "Unpacking the downloads..."

#Versions
$apocVersion = "3.5.0.9"
$neo4jVersion = "3.5.17"
$gdsVersion = "1.1.0-preview"
$algoVersion = "3.5.14.0"

#Files
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$jdkZip = "zulu8.44.0.11-ca-jdk8.0.242-win_x64.zip"
$gdsZip = "neo4j-graph-data-science-$($gdsVersion)-standalone.zip"
$gdsJar = "neo4j-graph-data-science-$($gdsVersion)-standalone.jar"
$algoZip = "neo4j-graph-algorithms-$($algoVersion)-standalone.zip"
$apocJar = "apoc-$($apocVersion)-all.jar"
$algoJar = "neo4j-graph-algorithms-$($algoVersion)-standalone.jar"

#Install Path
$installPath = Join-Path (Get-Location).Path "install"

#Unzip zipped things
$expandPath = Join-Path $installPath $neo4jZip
Expand-Archive -Force $expandPath ".\"
Write-Host "That's Neo4j done"
$expandPath = Join-Path $installPath $jdkZip
Expand-Archive -Force $expandPath ".\"
Write-Host "JDK as well"
$expandPath = Join-Path $installPath $algoZip
Expand-Archive -Force $expandPath ".\install"
Write-Host "ALGO jar now in install"

#Move things to be moved
$apocLocation = Join-Path $installPath $apocJar
$apocDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $apocJar
Move-Item -Force -Path $apocLocation -Destination $apocDestination
Write-Host "APOC is now in place"

$algoLocation = Join-Path $installPath $algoJar
$algoDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $algoJar
Move-Item -Force -Path $algoLocation -Destination $algoDestination
Write-Host "ALGO is now in place"
