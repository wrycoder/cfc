DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS Signature;
DROP TABLE IF EXISTS Recommendation;
DROP TABLE IF EXISTS Resource;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS TagCategory;

CREATE TABLE Users (
  id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name      CHAR(50),
  email     CHAR(50),
  phone     CHAR(12)
);

CREATE TABLE Roles (
  id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  label     CHAR(15)
);
CREATE INDEX role_label_index
  ON Roles(label);

CREATE TABLE Signatures (
  user_id   INTEGER,
  role_id   INTEGER,
  resource_id INTEGER,
  PRIMARY KEY (user_id, role_id, resource_id)
);
CREATE INDEX signature_resource_index
  ON Signatures(resource_id);

CREATE TABLE Recommendations (
  user_id   INTEGER,
  role_id   INTEGER,
  resource_id INTEGER,
  at        TIMESTAMP,
  PRIMARY KEY (user_id, role_id, resource_id)
);
CREATE INDEX recommendation_date_index
  ON Recommendations(at);
CREATE INDEX recommendation_person_index
  ON Recommendations(user_id);

CREATE TABLE Resources (
  id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  title     CHAR(100),
  category  CHAR(15),
  accessor  VARCHAR
);
CREATE INDEX resource_title_index
  ON Resources(title);
CREATE INDEX resource_category_index
  ON Resources(category);

CREATE TABLE TagCategories (
  id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  label     CHAR(15)
);
CREATE INDEX tagcategory_label_index
  ON TagCategories(label);

CREATE TABLE Tags(
  id            INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  resource_id   INTEGER,
  category_id   INTEGER
);
CREATE INDEX tag_resource_index
  ON Tags(resource_id);
CREATE INDEX tag_category_index
  ON Tags(category_id);

INSERT INTO Users(name, phone, email)
  VALUES
  ('Bob Smith','317-788-3333','bob@stmartins.org'),
  ('Katie Roberts','317-888-2222','katie@stalbans.org'),
  ('Harvey Miller','317-233-8888','harvey@hebrewcong.org'),
  ('Rhonda K. Brown','317-777-4444','rhonda@hoperenewed.org'),
  ('Sterling St. John','317-444-2222','sterling@stpatricks.org'),
  ('Brendan Shapiro','501-488-8888','brendan@marriageadvice.com'),
  ('Fr. Robert Stevens','212-435-8821','frbob@catholicleague.org'),
  ('Hans Schmidt','800-225-3355','hans@mychurchbooks.com'),
  ('Sven Richter','800-721-3388','sven@youthcouncil.net'),
  ('Patty McMillan','317-222-4444','patty@holyfamily.org');

INSERT INTO Roles(label)
  VALUES ('author'), ('advocate'), ('recommender'), ('recommendee');

INSERT INTO TagCategories(label)
  VALUES
  ('pastoral counseling'),
  ('substance abuse'),
  ('activism'),
  ('congregational finances'),
  ('fundraising'),
  ('infrastructure');

INSERT INTO Resources(title, category, accessor)
  VALUES
  ('Where We Go from Here: Disaster Recovery','website','https://christianitytoday.org/articles/2024/1/25'),
  ('Faith in Practice','book','ISBN: 7235151553'),
  ('Faith-based Treatment Options','website','https://updates.healthyfamilies.org/articles/stevens'),
  ('The Path to Responsible Stewardship','book','ISBN: 232332525'),
  ('Partners in Activism','website','https://www.wearepartners.org'),
  ('Indy''s Holiest of Holy Cards','business','https://www.holycards.org'),
  ('Candles and Such','business','https://www.allcandles.org'),
  ('Moral Clarity','website','https://www.moralclarity.net'),
  ('African Spiritual Adventures','book','ISBN: 888225225'),
  ('After the War is Over','website','https://www.afterallwar.net');
