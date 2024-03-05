/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[email]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
CREATE SEQUENCE book_code_seq;
ALTER TABLE "Book" ALTER COLUMN "code" SET DEFAULT nextval('book_code_seq');
ALTER SEQUENCE book_code_seq OWNED BY "Book"."code";

-- AlterTable
CREATE SEQUENCE client_code_seq;
ALTER TABLE "Client" ALTER COLUMN "code" SET DEFAULT nextval('client_code_seq');
ALTER SEQUENCE client_code_seq OWNED BY "Client"."code";

-- AlterTable
CREATE SEQUENCE copy_code_seq;
ALTER TABLE "Copy" ALTER COLUMN "code" SET DEFAULT nextval('copy_code_seq');
ALTER SEQUENCE copy_code_seq OWNED BY "Copy"."code";

-- AlterTable
CREATE SEQUENCE employee_code_seq;
ALTER TABLE "Employee" ALTER COLUMN "code" SET DEFAULT nextval('employee_code_seq');
ALTER SEQUENCE employee_code_seq OWNED BY "Employee"."code";

-- AlterTable
CREATE SEQUENCE legalclient_client_code_seq;
ALTER TABLE "LegalClient" ALTER COLUMN "client_code" SET DEFAULT nextval('legalclient_client_code_seq');
ALTER SEQUENCE legalclient_client_code_seq OWNED BY "LegalClient"."client_code";

-- AlterTable
CREATE SEQUENCE order_number_seq;
ALTER TABLE "Order" ALTER COLUMN "number" SET DEFAULT nextval('order_number_seq');
ALTER SEQUENCE order_number_seq OWNED BY "Order"."number";

-- AlterTable
CREATE SEQUENCE orderhascopy_id_seq;
ALTER TABLE "OrderHasCopy" ALTER COLUMN "id" SET DEFAULT nextval('orderhascopy_id_seq');
ALTER SEQUENCE orderhascopy_id_seq OWNED BY "OrderHasCopy"."id";

-- AlterTable
CREATE SEQUENCE physicalclient_client_code_seq;
ALTER TABLE "PhysicalClient" ALTER COLUMN "client_code" SET DEFAULT nextval('physicalclient_client_code_seq');
ALTER SEQUENCE physicalclient_client_code_seq OWNED BY "PhysicalClient"."client_code";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "pk_user",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "pk_user" PRIMARY KEY ("id");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
