mkdir install

export neo4jVersion="4.1.1"
export apocVersion="4.1.0.1"
export gdsVersion="1.3.0"
export zuluVersion="11.41.23"
export jreVersion="11.0.8"

curl -L -o "install/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip" https://cdn.azul.com/zulu/bin/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip
curl -L -o "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
curl -L -o "install/apoc-${apocVersion}-all.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-${apocVersion}-all.jar
curl -L -o "install/apoc-nlp-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-nlp-dependencies-${apocVersion}.jar
curl -L -o "install/apoc-mongodb-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-mongodb-dependencies-${apocVersion}.jar
curl -L -o "install/neo4j-graph-data-science-${gdsVersion}-standalone.zip"  https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/neo4j-graph-data-science-${gdsVersion}-standalone.zip
