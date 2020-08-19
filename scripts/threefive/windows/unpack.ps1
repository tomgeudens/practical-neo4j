Write-Host "Unpacking the downloads..."

#Versions
. .\scripts\version.ps1

#Files
$jreZip = "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64.zip"
$neo4jZip = "neo4j-enterprise-$($neo4jVersion)-windows.zip"
$gdsZip = "neo4j-graph-data-science-$($gdsVersion)-standalone.zip"
$gdsJar = "neo4j-graph-data-science-$($gdsVersion)-standalone.jar"
$apocJar = "apoc-$($apocVersion)-all.jar"
#$apocCoreJar = "apoc-$($apocVersion)-core.jar" - alternative for all
#$apocNLPJar = "apoc-nlp-dependencies-$($apocVersion).jar"
$apocMongoDBJar = "apoc-mongodb-dependencies-$($apocVersion).jar"

#Install Path
$installPath = Join-Path (Get-Location).Path "install"

#Unzip zipped things
Write-Host "Unpacking " -NoNewLine; Write-Host "Neo4j" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
$expandPath = Join-Path $installPath $neo4jZip
Expand-Archive -Force $expandPath ".\"
Write-Host "Done!" -ForegroundColor Green

Write-Host "Unpacking " -NoNewLine; Write-Host "JRE" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
$expandPath = Join-Path $installPath $jreZip
Expand-Archive -Force $expandPath ".\"
Write-Host "Done!" -ForegroundColor Green

Write-Host "Unpacking " -NoNewLine; Write-Host "GDS" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
$expandPath = Join-Path $installPath $gdsZip
Expand-Archive -Force $expandPath ".\install"
Write-Host "Done!" -ForegroundColor Green

#Move things to be moved
Write-Host "Moving " -NoNewLine; Write-Host "APOC" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
$apocLocation = Join-Path $installPath $apocJar
$apocDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $apocJar
Move-Item -Force -Path $apocLocation -Destination $apocDestination
Write-Host "Done!" -ForegroundColor Green

#Write-Host "Moving " -NoNewLine; Write-Host "APOC Core" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
#$apocCoreLocation = Join-Path $installPath $apocCoreJar
#$apocCoreDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $apocCoreJar
#Move-Item -Force -Path $apocCoreLocation -Destination $apocCoreDestination
#Write-Host "Done!" -ForegroundColor Green

#Write-Host "Moving " -NoNewLine; Write-Host "APOC NLP Dependencies" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
#$apocNLPLocation = Join-Path $installPath $apocNLPJar
#$apocNLPDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $apocNLPJar
#Move-Item -Force -Path $apocNLPLocation -Destination $apocNLPDestination
#Write-Host "Done!" -ForegroundColor Green

Write-Host "Moving " -NoNewLine; Write-Host "APOC MongoDB Dependencies" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
$apocMongoDBLocation = Join-Path $installPath $apocMongoDBJar
$apocMongoDBDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $apocMongoDBJar
Move-Item -Force -Path $apocMongoDBLocation -Destination $apocMongoDBDestination
Write-Host "Done!" -ForegroundColor Green

Write-Host "Moving " -NoNewLine; Write-Host "GDS" -ForegroundColor Cyan -NoNewline; Write-Host " ... " -NoNewline
$gdsLocation = Join-Path $installPath $gdsJar
$gdsDestination = Join-Path "neo4j-enterprise-$($neo4jVersion)\plugins" $gdsJar
Move-Item -Force -Path $gdsLocation -Destination $gdsDestination
Write-Host "Done!" -ForegroundColor Green

Write-Host "`nUnpacking Complete" -ForegroundColor Green
