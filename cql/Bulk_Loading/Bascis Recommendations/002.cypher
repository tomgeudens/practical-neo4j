// 002 Much better
MATCH (tom:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m1:Movie)<-[:ACTED_IN]-(coActors:Person)-[:ACTED_IN]->(m2:Movie)<-[:ACTED_IN]-(cocoActors:Person)
WHERE NOT (tom)-[:ACTED_IN]->()<-[:ACTED_IN]-(cocoActors)
AND tom <> cocoActors
RETURN cocoActors.name AS Recommended, collect(DISTINCT coActors.name), count(DISTINCT coActors.name) AS Strength ORDER BY Strength DESC;
