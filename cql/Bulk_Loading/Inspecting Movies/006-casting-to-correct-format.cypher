// 006 Casting to correct format
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/intro/movies/movies.csv' AS row
RETURN row.title as title, toInteger(row.released) as released, row.tagline as tagline
ORDER BY released DESC LIMIT 10;
