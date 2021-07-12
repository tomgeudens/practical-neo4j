// 001 - How many one hop patterns have Tom Hanks as the starting point?
MATCH (:Person {name: "Tom Hanks"})-[]->()
RETURN count(*);