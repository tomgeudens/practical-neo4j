mkdir install

. ./scripts/version.sh

curl -L -o "install/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip" https://cdn.azul.com/zulu/bin/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip
curl -L -o "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
curl -L -o "install/apoc-${apocVersion}-all.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-${apocVersion}-all.jar
curl -L -o "install/apoc-couchbase-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-couchbase-dependencies-${apocVersion}.jar
curl -L -o "install/apoc-email-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-email-dependencies-${apocVersion}.jar
curl -L -o "install/apoc-mongodb-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-mongodb-dependencies-${apocVersion}.jar
curl -L -o "install/apoc-nlp-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-nlp-dependencies-${apocVersion}.jar
curl -L -o "install/apoc-xls-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-xls-dependencies-${apocVersion}.jar
curl -L -o "install/neo4j-graph-data-science-${gdsVersion}.zip"  https://graphdatascience.ninja/neo4j-graph-data-science-${gdsVersion}.zip
