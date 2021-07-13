// 001 - Schema
CREATE CONSTRAINT uc_Movie_title ON (m:Movie) ASSERT m.title IS UNIQUE;
CREATE CONSTRAINT uc_Person_name ON (p:Person) ASSERT p.name IS UNIQUE;
CREATE INDEX ix_Movie_tagline FOR (m:Movie) ON (m.tagline);
