// 012 Just an update?
MATCH (tr:Trainer {name: "Tom Geudens"})-[t:TEACHES]->(f:Training {title: "Basics"})
SET tr.age = 48, t.at = time("10:00:00"), f.duration = duration("PT2H")
RETURN tr, t, f;
