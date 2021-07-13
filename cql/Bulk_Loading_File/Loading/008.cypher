// 008 - Verify the Something's Gotta Give node
MATCH (m:Movie) 
WHERE m.title = "Something's Gotta Give" 
RETURN m;
