tar -xzf install/zulu8.46.0.19-ca-jre8.0.252-linux_x64.tar.gz
tar -xzf install/neo4j-enterprise-3.5.19-unix.tar.gz
unzip -q install/neo4j-graph-data-science-1.1.3-standalone.zip -d install

mv install/apoc-3.5.0.12-all.jar neo4j-enterprise-3.5.19/plugins
mv install/apoc-mongodb-dependencies-3.5.0.12.jar neo4j-enterprise-3.5.19/plugins
mv install/neo4j-graph-data-science-1.1.3-standalone.jar neo4j-enterprise-3.5.19/plugins
