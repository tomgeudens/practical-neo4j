// 001 Expected Person Nodes
LOAD CSV FROM 'http://data.neo4j.com/intro/movies/people.csv'
AS row RETURN count(*);
