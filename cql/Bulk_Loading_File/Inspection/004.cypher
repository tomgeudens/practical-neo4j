// 004 - Expected ACTED_IN relationships
LOAD CSV FROM "file:///movies/basic/relationships/ACTED_IN.csv" AS row
RETURN count(*);
