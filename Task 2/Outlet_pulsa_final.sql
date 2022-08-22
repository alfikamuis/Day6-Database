CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "status" smallint NOT NULL,
  "dob" date NOT NULL,
  "gender" char(1) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

CREATE TABLE "payment_methods" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "status" smallint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

CREATE TABLE "transactions" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int(11) NOT NULL,
  "payment_method_id" int(11) NOT NULL,
  "status" varchar(10) NOT NULL,
  "total_qty" int(11) NOT NULL,
  "total_price" numeric(25,2) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

CREATE TABLE "transaction_details" (
  "transaction_id" int(11) NOT NULL,
  "product_id" int(11) NOT NULL,
  "status" varchar(10) NOT NULL,
  "qty" int(11) NOT NULL,
  "price" numeric(25,2) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

CREATE TABLE "products" (
  "id" SERIAL PRIMARY KEY,
  "product_type_id" int(11) NOT NULL,
  "operator_id" int(11) NOT NULL,
  "code" varchar(50) NOT NULL,
  "name" varchar(100) NOT NULL,
  "status" smallint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

CREATE TABLE "product_types" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

CREATE TABLE "operators" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

CREATE TABLE "product_descriptions" (
  "id" int(11) NOT NULL,
  "description" text NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp NOT NULL
);

ALTER TABLE "transactions" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "transactions" ADD FOREIGN KEY ("payment_method_id") REFERENCES "payment_methods" ("id");

CREATE TABLE "transactions_transaction_details" (
  "transactions_id" int(11) NOT NULL,
  "transaction_details_transaction_id" int(11) NOT NULL,
  PRIMARY KEY ("transactions_id", "transaction_details_transaction_id")
);

ALTER TABLE "transactions_transaction_details" ADD FOREIGN KEY ("transactions_id") REFERENCES "transactions" ("id");

ALTER TABLE "transactions_transaction_details" ADD FOREIGN KEY ("transaction_details_transaction_id") REFERENCES "transaction_details" ("transaction_id");


CREATE TABLE "products_transaction_details" (
  "products_id" int(11) NOT NULL,
  "transaction_details_product_id" int(11) NOT NULL,
  PRIMARY KEY ("products_id", "transaction_details_product_id")
);

ALTER TABLE "products_transaction_details" ADD FOREIGN KEY ("products_id") REFERENCES "products" ("id");

ALTER TABLE "products_transaction_details" ADD FOREIGN KEY ("transaction_details_product_id") REFERENCES "transaction_details" ("product_id");


CREATE TABLE "product_types_products" (
  "product_types_id" int(11) NOT NULL,
  "products_product_type_id" int(11) NOT NULL,
  PRIMARY KEY ("product_types_id", "products_product_type_id")
);

ALTER TABLE "product_types_products" ADD FOREIGN KEY ("product_types_id") REFERENCES "product_types" ("id");

ALTER TABLE "product_types_products" ADD FOREIGN KEY ("products_product_type_id") REFERENCES "products" ("product_type_id");


CREATE TABLE "operators_products" (
  "operators_id" int(11) NOT NULL,
  "products_operator_id" int(11) NOT NULL,
  PRIMARY KEY ("operators_id", "products_operator_id")
);

ALTER TABLE "operators_products" ADD FOREIGN KEY ("operators_id") REFERENCES "operators" ("id");

ALTER TABLE "operators_products" ADD FOREIGN KEY ("products_operator_id") REFERENCES "products" ("operator_id");


ALTER TABLE "product_descriptions" ADD FOREIGN KEY ("id") REFERENCES "products" ("id");
