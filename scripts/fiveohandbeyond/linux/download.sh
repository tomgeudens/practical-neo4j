mkdir install

. ./scripts/version.sh

wget -O "install/OpenJDK${javaVersion}U-jre_x64_linux_hotspot_${temurinFileVersion}.tar.gz" https://github.com/adoptium/temurin${javaVersion}-binaries/releases/download/jdk-${temurinURLVersion}/OpenJDK${javaVersion}U-jre_x64_linux_hotspot_${temurinFileVersion}.tar.gz
wget -O "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
wget -O "install/neo4j-graph-data-science-${gdsVersion}.zip"  https://graphdatascience.ninja/neo4j-graph-data-science-${gdsVersion}.zip
