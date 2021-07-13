// 007 - Casting to correct format
LOAD CSV WITH HEADERS FROM "file:///movies/basic/nodes/Person.csv" AS row
RETURN row.name as name, toInteger(row.born) as born
ORDER BY born ASC
LIMIT 10;
