# Opening statement
Write-Host -ForegroundColor Green -BackgroundColor Black "Starting Cypher Shell!"

# Version
. .\scripts\version.ps1

# Directories
$neo4jLocation = Join-Path (Get-Location).Path "neo4j-enterprise-$($neo4jVersion)"
$javaJRELocation = Join-Path (Get-Location).Path "zulu$($zuluVersion)-ca-jre$($jreVersion)-win_x64"

Write-Host "Setting Java Environment for this session ... " -NoNewline
$env:JAVA_HOME = $javaJRELocation
$env:PATH = "$($javaJRELocation)\bin;" + $env:PATH
Write-Host "Done!" -ForegroundColor Green

# Set-Variable -Name "NEO4J_USERNAME" -Value "neo4j"
# Set-Variable -Name "NEO4J_PASSWORD" -Value "trinity"
Write-Host "Setting User Environment for this session ... " -NoNewline
$env:NEO4J_USERNAME = $NEO4J_USERNAME
$env:NEO4J_PASSWORD = $NEO4J_PASSWORD
Write-Host "Done!" -ForegroundColor Green

$Arguments = @()
$Arguments += @("-jar",
        "neo4j-enterprise-$($neo4jVersion)\bin\tools\cypher-shell.jar")
$Arguments += $args

Start-Process java -ArgumentList $Arguments -Wait -NoNewWindow
