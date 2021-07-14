// 019 - Introducing collect
UNWIND apoc.coll.randomItems(range(1, 100), 100, true) AS aRandomNumber
RETURN aRandomNumber, collect(aRandomNumber) as occurences
ORDER BY aRandomNumber ASC;
