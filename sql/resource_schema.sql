DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS Signature;
DROP TABLE IF EXISTS Recommendation;
DROP TABLE IF EXISTS Resource;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS TagCategory;

CREATE TABLE User (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  name      CHAR(50),
  email     CHAR(50),
  phone     CHAR(12)
);

CREATE TABLE Role (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  label     CHAR(15)
);

CREATE TABLE Signature (
  user_id   INTEGER,
  role_id   INTEGER,
  resource_id INTEGER,
  PRIMARY KEY (user_id, role_id, resource_id)
);

CREATE TABLE Recommendation (
  user_id   INTEGER,
  role_id   INTEGER,
  resource_id INTEGER,
  at        TIMESTAMP,
  PRIMARY KEY (user_id, role_id, resource_id)
);
CREATE INDEX recommendation_date_index
  ON Recommendation(at);
CREATE INDEX recommendation_person_index
  ON Recommendation(user_id);

CREATE TABLE Resource (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  title     CHAR(100),
  category  CHAR(15),
  accessor  VARCHAR
);

CREATE TABLE TagCategory (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  label     CHAR(15)
);

CREATE TABLE Tag(
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  resource_id   INTEGER,
  category_id   INTEGER
);
CREATE INDEX tag_resource_index
  ON Tag(resource_id);
CREATE INDEX tag_category_index
  ON Tag(category_id);
