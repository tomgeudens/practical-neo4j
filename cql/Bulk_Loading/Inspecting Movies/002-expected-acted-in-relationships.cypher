// 002 Expected ACTED_IN Relationships
LOAD CSV FROM 'http://data.neo4j.com/intro/movies/actors.csv' 
AS row RETURN count(*);
