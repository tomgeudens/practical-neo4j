. ./scripts/version.sh

mv neo4j-${neo4jEdition}-${neo4jVersion}/labs/apoc*core.jar neo4j-${neo4jEdition}-${neo4jVersion}/plugins
mv install/neo4j-graph-data-science-${gdsVersion}.jar neo4j-${neo4jEdition}-${neo4jVersion}/plugins
