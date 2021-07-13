// 005 WITH HEADERS
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/intro/movies/movies.csv' AS row 
RETURN row, keys(row) LIMIT 5;

