CREATE TABLE "Products" (
  "id" BIGSERIAL PRIMARY KEY,
  "product" varchar NOT NULL,
  "product_type" varchar NOT NULL,
  "product_description" varchar,
  "operator" varchar NOT NULL,
  "payment_methods" varchar NOT NULL
);

CREATE TABLE "accounts" (
  "id" BIGSERIAL PRIMARY KEY,
  "nama" varchar,
  "alamat" varchar,
  "tanggal_lahir" datetime,
  "status_user" varchar,
  "gender" varchar,
  "created_at" timestamptz NOT NULL DEFAULT 'now()',
  "update_at" timestamp
);

CREATE TABLE "transactions" (
  "id" BIGSERIAL PRIMARY KEY,
  "customer_id" bigint NOT NULL,
  "product_id" bigint NOT NULL,
  "ammount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()'
);

CREATE INDEX ON "Products" ("product");

CREATE INDEX ON "accounts" ("nama");

CREATE INDEX ON "transactions" ("customer_id");

CREATE INDEX ON "transactions" ("product_id");

CREATE INDEX ON "transactions" ("customer_id", "product_id");

COMMENT ON COLUMN "transactions"."ammount" IS 'must be positive';

ALTER TABLE "transactions" ADD FOREIGN KEY ("customer_id") REFERENCES "accounts" ("id");

ALTER TABLE "transactions" ADD FOREIGN KEY ("product_id") REFERENCES "Products" ("id");
