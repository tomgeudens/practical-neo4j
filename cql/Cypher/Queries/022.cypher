// 022 - Ages of actors in The Matrix
MATCH (m:Movie)<-[a:ACTED_IN]-(p:Person)
WITH m, collect(p) as actors, avg(2021 - p.born) as averageageinmovie
UNWIND actors as actor
RETURN m.title, actor.name, 2021 - actor.born as actorage,  2021 - actor.born - averageageinmovie as agegapinmovie
