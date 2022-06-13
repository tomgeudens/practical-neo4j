mkdir install

. ./scripts/version.sh

wget -O "install/zulu${zuluVersion}-ca-jre${jreVersion}-linux_x64.tar.gz" https://cdn.azul.com/zulu/bin/zulu${zuluVersion}-ca-jre${jreVersion}-linux_x64.tar.gz
wget -O "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
wget -O "install/neo4j-graph-data-science-${gdsVersion}.zip"  https://graphdatascience.ninja/neo4j-graph-data-science-${gdsVersion}.zip
