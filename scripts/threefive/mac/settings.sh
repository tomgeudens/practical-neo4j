. ./scripts/version.sh

# changes to neo4j.conf file
echo "metrics.enabled=false" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.security.procedures.unrestricted=apoc.*,gds.*" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.connectors.default_listen_address=0.0.0.0" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.heap.initial_size=1024m" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.heap.max_size=1024m" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.pagecache.size=1g" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.udc.enabled=false" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.tx_log.rotation.retention_policy=1G size" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "apoc.import.file.enabled=true" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "apoc.export.file.enabled=true" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf

# setting the initial password
export JAVA_HOME=$(pwd)/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64
export PATH=$JAVA_HOME/bin:$PATH
neo4j-enterprise-${neo4jVersion}/bin/neo4j-admin set-initial-password trinity
