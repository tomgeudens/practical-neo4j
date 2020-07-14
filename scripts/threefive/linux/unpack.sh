export neo4jVersion="3.5.20"
export apocVersion="3.5.0.12"
export gdsVersion="1.1.3"

tar -xzf install/zulu8.46.0.19-ca-jre8.0.252-linux_x64.tar.gz
tar -xzf install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz
unzip -q install/neo4j-graph-data-science-${gdsVersion}-standalone.zip -d install

mv install/apoc-${apocVersion}-all.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/apoc-mongodb-dependencies-${apocVersion}.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/neo4j-graph-data-science-${gdsVersion}-standalone.jar neo4j-enterprise-${neo4jVersion}/plugins
