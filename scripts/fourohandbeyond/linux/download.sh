mkdir install

. ./scripts/version.sh

wget -O "install/zulu${zuluVersion}-ca-jre${jreVersion}-linux_x64.tar.gz" https://cdn.azul.com/zulu/bin/zulu${zuluVersion}-ca-jre${jreVersion}-linux_x64.tar.gz
wget -O "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
wget -O "install/apoc-${apocVersion}-all.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-${apocVersion}-all.jar
wget -O "install/apoc-nlp-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-nlp-dependencies-${apocVersion}.jar
wget -O "install/apoc-mongodb-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-mongodb-dependencies-${apocVersion}.jar
wget -O "install/neo4j-graph-data-science-${gdsVersion}-standalone.zip"  https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/neo4j-graph-data-science-${gdsVersion}-standalone.zip
