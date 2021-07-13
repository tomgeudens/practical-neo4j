// 002 - Expected Movie Nodes
LOAD CSV FROM "file:///movies/basic/nodes/Movie.csv" AS row
RETURN count(*);
