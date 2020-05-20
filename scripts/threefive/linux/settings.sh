# changes to neo4j.conf file
echo "metrics.enabled=false" >> neo4j-enterprise-3.5.17/conf/neo4j.conf
#echo "dbms.security.procedures.unrestricted=apoc.*,gds.*" >> neo4j-enterprise-3.5.17/conf/neo4j.conf
echo "dbms.security.procedures.unrestricted=apoc.*,algo.*" >> neo4j-enterprise-3.5.17/conf/neo4j.conf
echo "dbms.connectors.default_listen_address=0.0.0.0" >> neo4j-enterprise-3.5.17/conf/neo4j.conf
echo "dbms.memory.heap.initial_size=512m" >> neo4j-enterprise-3.5.17/conf/neo4j.conf
echo "dbms.memory.heap.max_size=512m" >> neo4j-enterprise-3.5.17/conf/neo4j.conf
echo "dbms.memory.pagecache.size=1g" >> neo4j-enterprise-3.5.17/conf/neo4j.conf
echo "dbms.tx_log.rotation.retention_policy=1G size" >> neo4j-enterprise-3.5.17/conf/neo4j.conf

# setting the initial password
export JAVA_HOME=$(pwd)/zulu8.44.0.11-ca-jdk8.0.242-linux_x64
export PATH=$JAVA_HOME/bin:$PATH
neo4j-enterprise-3.5.17/bin/neo4j-admin set-initial-password trinity
