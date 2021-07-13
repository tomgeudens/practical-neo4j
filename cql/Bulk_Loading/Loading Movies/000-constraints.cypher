// 000 Constraints
CREATE CONSTRAINT cu_Movie_title ON (m:Movie) ASSERT m.title IS UNIQUE;
CREATE CONSTRAINT cu_Person_name ON (p:Person) ASSERT p.name IS UNIQUE;