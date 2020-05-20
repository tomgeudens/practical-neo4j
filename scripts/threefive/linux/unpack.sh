tar -xzf install/zulu8.44.0.11-ca-jdk8.0.242-linux_x64.tar.gz
tar -xzf install/neo4j-enterprise-3.5.17-unix.tar.gz
unzip install/neo4j-graph-algorithms-3.5.14.0-standalone.zip -d install
mv install/apoc-3.5.0.9-all.jar neo4j-enterprise-3.5.17/plugins
mv install/neo4j-graph-algorithms-3.5.14.0-standalone.jar neo4j-enterprise-3.5.17/plugins
