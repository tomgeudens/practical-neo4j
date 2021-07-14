// 020 - WITH in action
MATCH (m:Movie)<-[a:ACTED_IN]-(p:Person)
WITH m.title AS title, m.released as released, collect(p.name) AS cast
RETURN title, released, cast, size(cast) as sizecast
