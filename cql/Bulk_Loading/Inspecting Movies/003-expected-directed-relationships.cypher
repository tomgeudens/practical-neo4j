// 003 Expected DIRECTED Relationships
LOAD CSV FROM 'http://data.neo4j.com/intro/movies/directors.csv'
AS row RETURN count(*);
