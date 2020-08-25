. ./scripts/version.sh

unzip -q install/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64.zip
tar -xzf install/neo4j-enterprise-${neo4jVersion}-unix.tar.gz
unzip -q install/neo4j-graph-data-science-${gdsVersion}-standalone.zip -d install

mv install/apoc-${apocVersion}-all.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/apoc-mongodb-dependencies-${apocVersion}.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/apoc-nlp-dependencies-${apocVersion}.jar neo4j-enterprise-${neo4jVersion}/plugins
mv install/neo4j-graph-data-science-${gdsVersion}-standalone.jar neo4j-enterprise-${neo4jVersion}/plugins
