Write-Host "Unpacking the downloads..."

#Versions
$apocVersion = "4.0.0.12"
$neo4jVersion = "4.0.4"

#Files
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$jdkZip = "zulu11.39.15-ca-jdk11.0.7-win_x64.zip"
$apocJar = "apoc-$($apocVersion)-all.jar"
$apocNLPJar = "apoc-nlp-dependencies-$($apocVersion).jar"

#Install Path
$installPath = Join-Path (Get-Location).Path "install"

#Unzip zipped things
$expandPath = Join-Path $installPath $neo4jZip
Expand-Archive -Force $expandPath ".\"
Write-Host "That's Neo4j done"
$expandPath = Join-Path $installPath $jdkZip
Expand-Archive -Force $expandPath ".\"
Write-Host "JDK as well"

#Move things to be moved
$apocLocation = Join-Path $installPath $apocJar
$apocDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $apocJar
Move-Item -Force -Path $apocLocation -Destination $apocDestination
Write-Host "APOC is now in place"
$apocNLPLocation = Join-Path $installPath $apocNLPJar
$apocNLPDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $apocNLPJar
Move-Item -Force -Path $apocNLPLocation -Destination $apocNLPDestination
Write-Host "APOC NLP dependencies are now in place"