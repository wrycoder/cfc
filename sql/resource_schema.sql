DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Signatures;
DROP TABLE IF EXISTS Recommendations;
DROP TABLE IF EXISTS Resources;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS TagCategories;

CREATE TABLE Users (
  id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name      CHAR(50),
  email     CHAR(50),
  phone     CHAR(12)
);
CREATE INDEX user_name_index
  ON Users(name);

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

CREATE TRIGGER users_signatures_trigger
AFTER DELETE on users
FOR EACH ROW
BEGIN
  DELETE from signatures
  WHERE user_id = OLD.id;
END;

CREATE TRIGGER signatures_resources_trigger
AFTER DELETE on signatures
FOR EACH ROW
BEGIN
  DELETE from resources
  WHERE id = OLD.resource_id;
END;

CREATE TABLE Recommendations (
  advocate_id   INTEGER,
  disciple_id   INTEGER,
  resource_id   INTEGER,
  at            DATETIME,
  PRIMARY KEY (advocate_id, disciple_id, resource_id)
);
CREATE INDEX recommendation_date_index
  ON Recommendations(at);
CREATE INDEX recommendation_advocate_index
  ON Recommendations(advocate_id);
CREATE INDEX recommendation_disciple_index
  ON Recommendations(disciple_id);

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
CREATE TRIGGER resources_recommendations_trigger
AFTER DELETE on resources
FOR EACH ROW
BEGIN
  DELETE from recommendations
  WHERE resource_id = OLD.id;
END;
CREATE TRIGGER users_recommendations_trigger
AFTER DELETE on users
FOR EACH ROW
BEGIN
  DELETE from recommendations
  WHERE advocate_id = OLD.id;
END;

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

/**
 * authors and advocates
 */
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

/**
 * ordinary users
 */
INSERT INTO Users(name, phone, email)
  VALUES
  ('Christina T. Anderson','910-843-8678','ChristinaTAnderson@teleworm.us'),
  ('Jeanette J. Johnson','858-538-1161','JeanetteJJohnson@teleworm.us'),
  ('James M. Appling','607-252-3314','JamesMAppling@teleworm.us'),
  ('Stephen D. Hochstetler','479-996-0326','StephenDHochstetler@rhyta.com'),
  ('Jason B. Wood','920-256-5022','JasonBWood@teleworm.us'),
  ('Ronald F. Howard','662-694-8547','RonaldFHoward@rhyta.com'),
  ('Jim P. Boykin','501-520-9930','JimPBoykin@teleworm.us'),
  ('Nancy A. Smith','605-581-2723','NancyASmith@rhyta.com'),
  ('Christopher Y. Martin','802-230-5520','ChristopherYMartin@armyspy.com'),
  ('Terrence L. Roberts','402-724-9408','TerrenceLRoberts@rhyta.com'),
  ('John D. McGaha','936-393-7722','JohnDMcGaha@jourrapide.com');

INSERT INTO Roles(label)
  VALUES ('author'), ('advocate');

INSERT INTO TagCategories(label)
  VALUES
  ('pastoral counseling'),
  ('substance abuse'),
  ('activism'),
  ('congregational finances'),
  ('fundraising'),
  ('infrastructure');

/**
 * create the resources
 */
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

/**
 * associate the resources with authors and advocates
 */
INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Bob Smith' and
      roles.label = 'advocate' and
      resources.title = 'Where We Go from Here: Disaster Recovery';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Hans Schmidt' and
      roles.label = 'author' and
      resources.title = 'African Spiritual Adventures';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Rhonda K. Brown' and
      roles.label = 'advocate' and
      resources.title = 'Partners in Activism';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Fr. Robert Stevens' and
      roles.label = 'advocate' and
      resources.title = 'Indy''s Holiest of Holy Cards';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Sterling St. John' and
      roles.label = 'advocate' and
      resources.title = 'Faith-based Treatment Options';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Harvey Miller' and
      roles.label = 'advocate' and
      resources.title = 'Candles and Such';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Brendan Shapiro' and
      roles.label = 'author' and
      resources.title = 'Faith in Practice';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Katie Roberts' and
      roles.label = 'author' and
      resources.title = 'The Path to Responsible Stewardship';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Sven Richter' and
      roles.label = 'advocate' and
      resources.title = 'After the War is Over';

INSERT INTO Signatures(user_id, role_id, resource_id)
SELECT users.id, roles.id, resources.id
FROM users, roles, resources
WHERE users.name = 'Patty McMillan' and
      roles.label = 'advocate' and
      resources.title = 'Moral Clarity';

/**
 * create the recommendations
 */
INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-04-18 13:25:14')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%Christoph%' and
      advocates.name like '%Harvey%' and
      resources.title like 'Moral%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-03-17 10:05:12')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like 'Terrence%' and
      advocates.name like 'Katie%' and
      resources.title like '%Responsible Stew%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-01-25 08:13:14')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like 'Christopher Y%' and
      advocates.name like 'Hans Schm%' and
      resources.title like 'African %';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-06-08 17:08:54')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%Hochstetler%' and
      advocates.name like 'Brendan S%' and
      resources.title like 'Faith in%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-09-28 19:45:34')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%nald F%' and
      advocates.name like 'Katie%' and
      resources.title like '%Path to%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-08-08 07:45:34')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like 'Nancy %' and
      advocates.name like '%Robert Stev%' and
      resources.title like 'Indy%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-06-15 06:55:14')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like 'James M%' and
      advocates.name like '%Robert Stev%' and
      resources.title like '%dles and%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-07-08 14:18:26')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%Boyk%' and
      advocates.name like '%Robert Stev%' and
      resources.title like '%Holiest%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-05-13 19:18:03')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%nald F%' and
      advocates.name like 'Harvey%' and
      resources.title like '%dles and%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-05-13 02:25:08')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%eanette%' and
      advocates.name like '%erling St%' and
      resources.title like '%ased Trea%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-10-08 12:08:21')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%ason B%' and
      advocates.name like '%atty M%' and
      resources.title like '%oral Cla%';

INSERT INTO Recommendations(disciple_id, advocate_id, resource_id, at)
SELECT disciples.id, advocates.id,
     resources.id, datetime('2023-02-27 08:23:01')
FROM users as disciples indexed by user_name_index,
     users as advocates indexed by user_name_index,
     resources
WHERE disciples.name like '%nald F%' and
      advocates.name like '%ven Rich%' and
      resources.title like '%fter the%';

