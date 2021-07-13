// 007 Do NOT execute this one ...
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/intro/movies/movies.csv'
AS row
CREATE (m:Movie {title: row.title, released: toInteger(row.released), tagline: row.tagline})
RETURN m;
