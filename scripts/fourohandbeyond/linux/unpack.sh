tar -xzf install/zulu11.39.15-ca-jre11.0.7-linux_x64.tar.gz
tar -xzf install/neo4j-enterprise-4.1.0-unix.tar.gz
unzip -q ./install/neo4j-graph-data-science-1.3.0-standalone.zip -d ./install

mv install/apoc-4.1.0.0-all.jar neo4j-enterprise-4.1.0/plugins
mv install/apoc-nlp-dependencies-4.1.0.0.jar neo4j-enterprise-4.1.0/plugins
mv install/apoc-mongodb-dependencies-4.1.0.0.jar neo4j-enterprise-4.1.0/plugins
mv install/neo4j-graph-data-science-1.3.0-standalone.jar neo4j-enterprise-4.1.0/plugins
