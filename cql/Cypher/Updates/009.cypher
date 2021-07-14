// 009 - remove a property, remove a label
MATCH (c:CEO)
REMOVE c.actor, c:CEO;
