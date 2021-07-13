// 000 Expected Movie Nodes
LOAD CSV FROM 'http://data.neo4j.com/intro/movies/movies.csv'
AS row RETURN count(*);
