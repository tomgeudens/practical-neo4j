// 021 - WITH with extra WHERE
MATCH (m:Movie)<-[a:ACTED_IN]-(p:Person)
WITH m.title AS title, m.released as released, collect(p.name) AS cast
ORDER BY size(cast) DESC
WHERE size(cast) > 4
RETURN title, released, cast, size(cast) as sizecast
