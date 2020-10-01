. ./scripts/version.sh

for i in {1..3}
do
   cp -R neo4j-enterprise-${neo4jVersion} neo4j-enterprise-${neo4jVersion}_$i
done
