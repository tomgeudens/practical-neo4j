param($password="trinity")

# Opening statement
Write-Host "Changing Settings..."

# Version
. .\scripts\version.ps1

# Directories
$neo4jLocation = Join-Path (Get-Location).Path "neo4j-enterprise-$($neo4jVersion)"
$javaJRELocation = Join-Path (Get-Location).Path "jdk-$($temurinHomeVersion)-jre"

# Configurationfile
$configFileLocation = Join-Path $neo4jLocation "conf\neo4j.conf"
$apocFileLocation = Join-Path $neo4jLocation "conf\apoc.conf"

#Add all the config you want here, newlines are added later.
$configLines = (
    "# Custom - Generic",
    "server.config.strict_validation.enabled=false",
    "# Custom - Metrics",     
    "server.metrics.enabled=true",
    "server.metrics.filter=*",
    "server.metrics.csv.enabled=false",
    "server.metrics.prometheus.enabled=false",
    "server.metrics.graphite.enabled=false",
    "server.metrics.jmx.enabled=true",
    "# Custom - Query Log",
    "db.logs.query.enabled=OFF",
    "# Custom - Miscellaneous",
    "dbms.db.timezone=SYSTEM",
    "dbms.security.procedures.unrestricted=apoc*,gds*",
    "browser.remote_content_hostname_whitelist=*",
    "# Custom - Memory",
    "server.memory.heap.initial_size=2g",
    "server.memory.heap.max_size=2g",
    "server.memory.pagecache.size=1g",
    "dbms.memory.transaction.total.max=2000m",
    "db.memory.transaction.max=1g",
    "# Custom - Network Settings",
    "server.default_listen_address=0.0.0.0",
    "# Custom - Transaction Log",
    "db.tx_log.rotation.retention_policy=1G size"
)
$apocLines = (
    "apoc.export.file.enabled=true",
    "apoc.import.file.enabled=true",
    "apoc.import.file.use_neo4j_config=true"
)

Write-Host "Adding config to " $configFileLocation
foreach($line in $configLines) {
    Add-Content -Path $configFileLocation -Value "`r`n$($line)"
    Write-Host "`t *" $line
}
Write-Host "Done!" -ForegroundColor Green

Write-Host "Adding config to " $apocFileLocation
foreach($line in $apocLines) {
    Add-Content -Path $apocFileLocation -Value "`r`n$($line)"
    Write-Host "`t *" $line
}
Write-Host "Done!" -ForegroundColor Green

Write-Host "Setting Java Environment for this session ... " -NoNewline
$env:JAVA_HOME = $javaJRELocation
$env:PATH = "$($javaJRELocation)\bin;" + $env:PATH
Write-Host "Done!" -ForegroundColor Green

Write-Host "Importing Neo4j Modules ... " -NoNewline
$neo4jModuleLocation = Join-Path $neo4jLocation "bin\Neo4j-Management.psd1"
Import-Module $neo4jModuleLocation
Write-Host "Done!" -ForegroundColor Green

Write-Host "Setting neo4j initial password ... " -NoNewline
Invoke-Neo4jAdmin dbms set-initial-password $password
Write-Host "Done!" -ForegroundColor Green

# All done
Write-Host "`nSettings Complete" -ForegroundColor Green
