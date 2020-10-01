. ./scripts/version.sh

export members=""
for i in {1..3}
do
  discovery=$(echo "5000 + $i" | bc)
  members="$members,127.0.0.1:$discovery"
done

for i in {1..3}
do
  discovery=$(echo "5000 + $i" | bc)
  transaction=$(echo "6000 + $i" | bc)
  raft=$(echo "7000 + $i" | bc)
  bolt=$(echo "7400 + $i" | bc)
  http=$(echo "7600 + $i" | bc)
  https=$(echo "7800 + $i" | bc)
  backup=$(echo "6500 + $i" | bc)
  # changes to neo4j.conf file
  echo "dbms.mode=CORE" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.minimum_core_cluster_size_at_formation=3" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.minimum_core_cluster_size_at_runtime=3" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.initial_discovery_members=${members:1}" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.discovery_listen_address=127.0.0.1:$discovery" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.transaction_listen_address=127.0.0.1:$transaction" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.raft_listen_address=127.0.0.1:$raft" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.discovery_advertised_address=127.0.0.1:$discovery" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.transaction_advertised_address=127.0.0.1:$transaction" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "causal_clustering.raft_advertised_address=127.0.0.1:$raft" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.bolt.enabled=true" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.bolt.advertised_address=127.0.0.1:$bolt" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.bolt.listen_address=127.0.0.1:$bolt" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.http.enabled=true" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.http.listen_address=127.0.0.1:$http" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.http.advertised_address=127.0.0.1:$http" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.https.enabled=false" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.https.listen_address=127.0.0.1:$https" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.connector.https.advertised_address=127.0.0.1:$https" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
  echo "dbms.backup.listen_address=127.0.0.1:$backup" >> neo4j-enterprise-${neo4jVersion}_$i/conf/neo4j.conf
done
