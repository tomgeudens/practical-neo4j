. ./scripts/version.sh

# changes to neo4j.conf file
echo "# Custom - Generic" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.config.strict_validation.enabled=false" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

echo "# Custom - Metrics" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.metrics.enabled=true" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.metrics.filter=*" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.metrics.csv.enabled=false" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.metrics.prometheus.enabled=false" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.metrics.graphite.enabled=false" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.metrics.jmx.enabled=true" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

echo "# Custom - Query Log" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "db.logs.query.enabled=OFF" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

echo "# Custom - Miscellaneous" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "dbms.db.timezone=SYSTEM" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "dbms.security.procedures.unrestricted=apoc*,gds*" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "browser.remote_content_hostname_whitelist=*" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

echo "# Custom - Memory" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.memory.heap.initial_size=2g" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.memory.heap.max_size=2g" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.memory.pagecache.size=1g" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "dbms.memory.transaction.total.max=2000m" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "db.memory.transaction.max=1g" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

echo "# Custom - Network Settings" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "server.default_listen_address=0.0.0.0" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

# there is now a reasonable default for this (after only 5 years of waiting for it ;-)
# echo "# Custom - Transaction Log" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
# echo "db.tx_log.rotation.retention_policy=1G size" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

echo "# no usage data collection please" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf
echo "dbms.usage_report.enabled=false" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/neo4j.conf

# create apoc.conf file
echo "apoc.export.file.enabled=true" > neo4j-${neo4jEdition}-${neo4jVersion}/conf/apoc.conf
echo "apoc.import.file.enabled=true" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/apoc.conf
echo "apoc.import.file.use_neo4j_config=true" >> neo4j-${neo4jEdition}-${neo4jVersion}/conf/apoc.conf

# setting the initial password
export JAVA_HOME="$(pwd)/jdk-${temurinHomeVersion}-jre"
export PATH="$JAVA_HOME/bin:$PATH"
neo4j-${neo4jEdition}-${neo4jVersion}/bin/neo4j-admin dbms set-initial-password morpheus
