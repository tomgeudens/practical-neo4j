// 001 - Expected Person Nodes
LOAD CSV FROM "file:///movies/basic/nodes/Person.csv" AS row
RETURN count(*);
