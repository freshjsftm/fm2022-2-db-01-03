DROP TABLE IF EXISTS "users";
CREATE TABLE "users"(
  "id" bigserial PRIMARY KEY,
  "firstName" varchar(64) NOT NULL CHECK ("firstName" != ''),
  "lastName" varchar(64) NOT NULL CHECK ("lastName" != ''),
  "email" varchar(256) NOT NULL CHECK ("email" != '') UNIQUE,
  "isMale" boolean NOT NULL,
  "birthday" date NOT NULL CHECK (
    "birthday" < current_date
    AND age("birthday") <= make_interval(150)
  ),
  "height" numeric(3, 2) NOT NULL CHECK (
    "height" > 0.40
    AND "height" < 2.50
  )
);
INSERT INTO "users"(
    "firstName",
    "lastName",
    "email",
    "isMale",
    "birthday",
    "height"
  )
VALUES (
    'Brad',
    'Pitt',
    'pitt@gmail.com',
    true,
    '1963-12-18',
    1.87
  ),
  (
    'Tom',
    'Rot',
    'rot@gmail.com',
    true,
    '1963-05-28',
    2.47
  ),
  (
    'Fred',
    'Pitt',
    'pitt2@gmail.com',
    true,
    '1903-12-18',
    1.87
  ),
  (
    'Elen',
    'Pitt',
    'pitt3@gmail.com',
    false,
    '1963-12-18',
    1.87
  ),
  (
    'Brad',
    'Doe',
    'pitt4@gmail.com',
    true,
    '2009-03-13',
    0.87
  ),
  (
    'Kate',
    'Pitt',
    'pitt5@gmail.com',
    true,
    '1963-12-18',
    1.87
  );
--додайте атрибут "weight" 
ALTER TABLE "users"
ADD COLUMN "weight" numeric(4, 1) NOT NULL DEFAULT 100 CHECK (
    "weight" > 1
    AND "weight" < 450
  );
-- CREATE EXTENSION "uuid-ossp";
DROP TABLE IF EXISTS "messages";
CREATE TABLE "messages"(
  "id" bigserial PRIMARY KEY,
  -- "id" uuid NOT NULL UNIQUE DEFAULT uuid_generate_v1(),
  "body" varchar(2048) NOT NULL CHECK ("body" != ''),
  "author" varchar(256) NOT NULL CHECK ("author" != ''),
  "createdAt" timestamp NOT NULL DEFAULT current_timestamp,
  "isRead" boolean NOT NULL DEFAULT false -- CONSTRAINT "CHECK_AUTHOR" CHECK ("author"!='')
);
INSERT INTO "messages" ("author", "body")
VALUES ('Brad Pitt', 'hi'),
('Brad Pitt', 'hi'),
('Brad Pitt', 'hi');

DROP TABLE IF EXISTS "manufactures";
CREATE TABLE "manufactures"(
  "id" bigserial PRIMARY KEY,
  "name" varchar(256) NOT NULL CHECK ("name" != ''),
  "industry" varchar(256) NOT NULL CHECK ("industry" != ''),
  "createdAt" date NOT NULL,
  "townRegistr" varchar(2048),
  UNIQUE("name", "industry"),
  CHECK ("createdAt" <= current_date),
  CHECK ("townRegistr" != '')
);
INSERT INTO "manufactures" ("name", "industry", "createdAt", "townRegistr")
VALUES ('Brad Pitt', 'textil', '2000-12-12', 'ny'),
('Brad Pitt', 'electronic', '2000-12-12', 'zp'),
('Brad Pitt', 'hi', '2000-12-12', 'zp');



CREATE TABLE "products"(
  "id" bigserial PRIMARY KEY,
  "title" varchar(64) NOT NULL CHECK("title" != '') UNIQUE,
  "price" numeric(7,2) NOT NULL CHECK("price">0 AND "price"<=1000000),
  "currency" varchar(8) NOT NULL CHECK("currency" != ''),
  "prodDate" date NOT NULL CHECK( "prodDate"<=current_date) DEFAULT current_date,
  "quantity" integer NOT NULL CHECK("quantity">0 AND "quantity"<1000000)
);

INSERT INTO "products"("title","price","currency","prodDate","quantity")
VALUES ('skate', 589.99, '$', '2022-12-18', 4),
('scooter', 7993.66, '$', '2022-02-23', 7),
('snowboard', 689.80, '$', '2022-05-21', 8),
('sled', 445.43, '$', '2022-11-08', 12),
('skis', 2456.75, '$', '2022-07-02', 7),
('bike', 6489.90, '$', '2022-05-11', 999);