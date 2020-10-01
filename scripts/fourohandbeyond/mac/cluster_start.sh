. ./scripts/version.sh
. ./scripts/environment.sh

for i in {1..3}
do
   neo4j-enterprise-${neo4jVersion}_$i/bin/neo4j start
done
