// 006 - Create the Movie nodes
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/basic/nodes/Movie.csv" AS row
  RETURN row
','
  CREATE (:Movie {title: row.title, released: toInteger(row.released), tagline: row.tagline});
',{batchSize:2000, parallel:true});
