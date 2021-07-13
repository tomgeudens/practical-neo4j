// 005 - Visually Inspecting the file
LOAD CSV FROM "file:///movies/basic/nodes/Movie.csv" AS row
RETURN row 
LIMIT 5;
