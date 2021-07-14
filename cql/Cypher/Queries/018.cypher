// 018 - Projection as you don't know it
MATCH (m:Movie {title: "The Matrix"})<-[a:ACTED_IN]-(p:Person)
RETURN m.title AS title, collect(p.name) AS cast, count(p) as sizecast;
