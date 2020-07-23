export neo4jVersion="4.1.1"
export apocVersion="4.1.0.1"
export gdsVersion="1.3.0"
export zuluVersion="11.41.23"
export jreVersion="11.0.8"

unzip -q install/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip
tar -xzf install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz
unzip -q install/neo4j-graph-data-science-${gdsVersion}-standalone.zip -d install

mv install/apoc-${apocVersion}-all.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/apoc-mongodb-dependencies-${apocVersion}.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/apoc-nlp-dependencies-${apocVersion}.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/neo4j-graph-data-science-${gdsVersion}-standalone.jar neo4j-enterprise-${neo4jVersion}/plugins
