// 002 - Create or update (MERGE) a relationship
MATCH (p:Person {name: "Tom Geudens"})
MATCH (m:Movie {title: "The Matrix"})
MERGE (p)-[i:IS_FAN_OF]->(m)
ON CREATE SET i.since = "he joined Neo4j", i.count=1
ON MATCH SET i.count = i.count + 1
RETURN p.name, i.since, i.count, m.title;
