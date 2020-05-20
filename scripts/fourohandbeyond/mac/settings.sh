# changes to neo4j.conf file
echo "metrics.enabled=false" >> neo4j-enterprise-4.0.3/conf/neo4j.conf
echo "dbms.security.procedures.unrestricted=apoc.*,algo.*" >> neo4j-enterprise-4.0.3/conf/neo4j.conf
echo "dbms.default_listen_address=0.0.0.0" >> neo4j-enterprise-4.0.3/conf/neo4j.conf
echo "dbms.logs.query.enabled=off" >> neo4j-enterprise-4.0.3/conf/neo4j.conf
echo "dbms.memory.heap.initial_size=512m" >> neo4j-enterprise-4.0.3/conf/neo4j.conf
echo "dbms.memory.heap.max_size=512m" >> neo4j-enterprise-4.0.3/conf/neo4j.conf
echo "dbms.memory.pagecache.size=1g" >> neo4j-enterprise-4.0.3/conf/neo4j.conf
echo "dbms.tx_log.rotation.retention_policy=1G size" >> neo4j-enterprise-4.0.3/conf/neo4j.conf

# setting the initial password
export JAVA_HOME=$(pwd)/zulu11.37.17-ca-jdk11.0.6-macosx_x64
export PATH=$JAVA_HOME/bin:$PATH
neo4j-enterprise-4.0.3/bin/neo4j-admin set-initial-password trinity
