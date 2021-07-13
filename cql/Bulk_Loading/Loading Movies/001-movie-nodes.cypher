// 001 Movie Nodes
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/intro/movies/movies.csv' AS row
CREATE (:Movie {title: row.title, released: toInteger(row.released), tagline: row.tagline});