// 003 - Expected DIRECTED relationships
LOAD CSV FROM "file:///movies/basic/relationships/DIRECTED.csv" AS row
RETURN count(*);
