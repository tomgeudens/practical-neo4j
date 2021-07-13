// 004 Visual Inspection
LOAD CSV FROM 'http://data.neo4j.com/intro/movies/movies.csv'
AS row RETURN * LIMIT 5;
