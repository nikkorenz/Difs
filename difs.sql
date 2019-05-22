--
-- Create a very simple database to hold item and category information
--
PRAGMA foreign_keys = ON;
CREATE TABLE item (
        id          INTEGER PRIMARY KEY,
        name       TEXT ,
        brand       TEXT,
        color       TEXT,
        note        TEXT,
        img         TEXT

);
-- 'item_category' is a many-to-many join table between items & categorys
CREATE TABLE item_category (
        item_id     INTEGER REFERENCES item(id) ON DELETE CASCADE ON UPDATE CASCADE,
        category_id   INTEGER REFERENCES category(id) ON DELETE CASCADE ON UPDATE CASCADE,
        PRIMARY KEY (item_id, category_id)
);
CREATE TABLE category (
        id          INTEGER PRIMARY KEY,
        name  TEXT
);
---
--- Load some sample data
---
INSERT INTO item VALUES (1, 'Nintendo Switch', 'Nintendo','','','');
INSERT INTO item VALUES (2, 'Guitar', 'Takamine','','','');
INSERT INTO item VALUES (3, 'Gym outfit', 'Nike','','','');
INSERT INTO item VALUES (4, 'Ultraboost ', 'Adidas','','','');
INSERT INTO item VALUES (5, 'Protein shake', 'Whey','','','');
INSERT INTO category VALUES (1, 'Gadgets');
INSERT INTO category VALUES (2, 'Games');
INSERT INTO category VALUES (3, 'Entertainment');
INSERT INTO category VALUES (4, 'Music');
INSERT INTO category VALUES (5, 'Clothing');
INSERT INTO category VALUES (6, 'Shoes');
INSERT INTO category VALUES (7, 'Lifestyle');
INSERT INTO category VALUES (8, 'Food');
INSERT INTO item_category VALUES (1, 1);
INSERT INTO item_category VALUES (1, 2);
INSERT INTO item_category VALUES (1, 3);
INSERT INTO item_category VALUES (2, 4);
INSERT INTO item_category VALUES (3, 5);
INSERT INTO item_category VALUES (4, 6);
INSERT INTO item_category VALUES (4, 7);
INSERT INTO item_category VALUES (5, 8);