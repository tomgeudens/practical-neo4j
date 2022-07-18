mkdir install

. ./scripts/version.sh

curl -L -o "install/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip" https://cdn.azul.com/zulu/bin/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip
curl -L -o "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
curl -L -o "install/neo4j-graph-data-science-${gdsVersion}.zip"  https://graphdatascience.ninja/neo4j-graph-data-science-${gdsVersion}.zip
