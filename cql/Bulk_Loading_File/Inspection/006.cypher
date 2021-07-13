// 006 - Visually Inspecting the file WITH HEADERS
LOAD CSV WITH HEADERS FROM "file:///movies/basic/nodes/Movie.csv" AS row
RETURN row, keys(row) 
LIMIT 5;
