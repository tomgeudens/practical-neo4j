// 017 - Projection as you know it
MATCH (m:Movie {title: "The Matrix"})<-[a:ACTED_IN]-(p:Person)
RETURN m.title AS title, p.name AS name
ORDER BY name DESC
SKIP 1 LIMIT 2;
