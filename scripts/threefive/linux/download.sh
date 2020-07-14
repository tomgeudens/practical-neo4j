mkdir install

export neo4jVersion="3.5.20"
export apocVersion="3.5.0.12"
export gdsVersion="1.1.3"

wget -O "install/zulu8.46.0.19-ca-jre8.0.252-linux_x64.tar.gz" https://cdn.azul.com/zulu/bin/zulu8.46.0.19-ca-jre8.0.252-linux_x64.tar.gz
wget -O "install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz" https://neo4j.com/artifact.php?name=neo4j-enterprise-${neo4jVersion}-unix.tar.gz
wget -O "install/apoc-${apocVersion}-all.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-${apocVersion}-all.jar
wget -O "install/apoc-mongodb-dependencies-${apocVersion}.jar" https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${apocVersion}/apoc-mongodb-dependencies-${apocVersion}.jar
wget -O "install/neo4j-graph-data-science-${gdsVersion}-standalone.zip"  https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/neo4j-graph-data-science-${gdsVersion}-standalone.zip
