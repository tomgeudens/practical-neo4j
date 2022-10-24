mkdir install

. ./scripts/version.sh

curl -L -o "install/OpenJDK${javaVersion}U-jre_x64_mac_hotspot_${temurinFileVersion}.tar.gz" https://github.com/adoptium/temurin${javaVersion}-binaries/releases/download/jdk-${temurinURLVersion}/OpenJDK${javaVersion}U-jre_x64_mac_hotspot_${temurinFileVersion}.tar.gz
curl -L -o "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
curl -L -o "install/neo4j-graph-data-science-${gdsVersion}.zip"  https://graphdatascience.ninja/neo4j-graph-data-science-${gdsVersion}.zip
