// 001 - Who should act with Tom?
MATCH (tom:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m1)<-[:ACTED_IN]-(coActors:Person)-[:ACTED_IN]->(m2)<-[:ACTED_IN]-(cocoActors:Person)
WHERE NOT (tom)-[:ACTED_IN]->()<-[:ACTED_IN]-(cocoActors)
AND tom <> cocoActors
RETURN cocoActors.name AS Recommended, count(*) AS Strength ORDER BY Strength DESC;
