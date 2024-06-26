. ./scripts/version.sh

# changes to neo4j.conf file
echo "metrics.enabled=true" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "metrics.namespaces.enabled=true" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "metrics.filter=*" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "metrics.csv.enabled=false" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "metrics.prometheus.enabled=false" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "metrics.graphite.enabled=false" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "metrics.jmx.enabled=true" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.security.procedures.unrestricted=apoc.*,gds.*" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.default_listen_address=0.0.0.0" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.logs.query.enabled=off" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.heap.initial_size=2g" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.heap.max_size=2g" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.pagecache.size=1g" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.transaction.global_max_size=2000m" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.tx_log.rotation.retention_policy=1G size" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.db.timezone=SYSTEM" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "dbms.logs.user.stdout_enabled=false" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf
echo "browser.remote_content_hostname_whitelist=*" >> neo4j-enterprise-${neo4jVersion}/conf/neo4j.conf

# create apoc.conf file
echo "apoc.export.file.enabled=true" > neo4j-enterprise-${neo4jVersion}/conf/apoc.conf
echo "apoc.import.file.enabled=true" >> neo4j-enterprise-${neo4jVersion}/conf/apoc.conf
echo "apoc.import.file.use_neo4j_config=true" >> neo4j-enterprise-${neo4jVersion}/conf/apoc.conf

# setting the initial password
export JAVA_HOME="$(pwd)/zulu${zuluVersion}-ca-jre${jreVersion}-linux_x64"
export PATH="$JAVA_HOME/bin:$PATH"
neo4j-enterprise-${neo4jVersion}/bin/neo4j-admin set-initial-password morpheus
