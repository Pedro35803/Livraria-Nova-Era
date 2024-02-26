/*
  Warnings:

  - The primary key for the `book_author` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `book_category` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `publisher_email` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `publisher_phone` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[cnpj]` on the table `legal_client` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[copy_code,order_number]` on the table `order_has_copy` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[cpf]` on the table `physical_client` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[rg]` on the table `physical_client` will be added. If there are existing duplicate values, this will fail.
  - Made the column `publisher_cnpj` on table `book` required. This step will fail if there are existing NULL values in that column.
  - Made the column `category` on table `book_category` required. This step will fail if there are existing NULL values in that column.
  - Made the column `book_code` on table `copy` required. This step will fail if there are existing NULL values in that column.
  - Made the column `employee_code` on table `in_person_order` required. This step will fail if there are existing NULL values in that column.
  - Made the column `customer_code` on table `order` required. This step will fail if there are existing NULL values in that column.
  - Made the column `order_number` on table `order_has_copy` required. This step will fail if there are existing NULL values in that column.
  - Made the column `copy_code` on table `order_has_copy` required. This step will fail if there are existing NULL values in that column.
  - Made the column `email` on table `publisher_email` required. This step will fail if there are existing NULL values in that column.
  - Made the column `phone` on table `publisher_phone` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "book" ALTER COLUMN "publisher_cnpj" SET NOT NULL;

-- AlterTable
ALTER TABLE "book_author" DROP CONSTRAINT "book_author_pkey",
ALTER COLUMN "book_code" DROP DEFAULT,
ADD CONSTRAINT "book_author_pkey" PRIMARY KEY ("book_code", "author");
DROP SEQUENCE "book_author_book_code_seq";

-- AlterTable
ALTER TABLE "book_category" DROP CONSTRAINT "book_category_pkey",
ALTER COLUMN "book_code" DROP DEFAULT,
ALTER COLUMN "category" SET NOT NULL,
ADD CONSTRAINT "book_category_pkey" PRIMARY KEY ("book_code", "category");
DROP SEQUENCE "book_category_book_code_seq";

-- AlterTable
ALTER TABLE "copy" ALTER COLUMN "book_code" SET NOT NULL;

-- AlterTable
ALTER TABLE "in_person_order" ALTER COLUMN "employee_code" SET NOT NULL;

-- AlterTable
ALTER TABLE "order" ALTER COLUMN "customer_code" SET NOT NULL;

-- AlterTable
ALTER TABLE "order_has_copy" ALTER COLUMN "order_number" SET NOT NULL,
ALTER COLUMN "copy_code" SET NOT NULL;

-- AlterTable
ALTER TABLE "publisher_email" DROP CONSTRAINT "publisher_email_pkey",
ALTER COLUMN "email" SET NOT NULL,
ADD CONSTRAINT "publisher_email_pkey" PRIMARY KEY ("publisher_cnpj", "email");

-- AlterTable
ALTER TABLE "publisher_phone" DROP CONSTRAINT "publisher_phone_pkey",
ALTER COLUMN "phone" SET NOT NULL,
ADD CONSTRAINT "publisher_phone_pkey" PRIMARY KEY ("publisher_cnpj", "phone");

-- CreateIndex
CREATE UNIQUE INDEX "legal_client_cnpj_key" ON "legal_client"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "order_has_copy_copy_code_order_number_key" ON "order_has_copy"("copy_code", "order_number");

-- CreateIndex
CREATE UNIQUE INDEX "physical_client_cpf_key" ON "physical_client"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "physical_client_rg_key" ON "physical_client"("rg");

-- AddForeignKey
ALTER TABLE "physical_client" ADD CONSTRAINT "physical_client_client_code_fkey" FOREIGN KEY ("client_code") REFERENCES "client"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "legal_client" ADD CONSTRAINT "legal_client_client_code_fkey" FOREIGN KEY ("client_code") REFERENCES "client"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "in_person_order" ADD CONSTRAINT "in_person_order_order_number_fkey" FOREIGN KEY ("order_number") REFERENCES "order"("number") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "in_person_order" ADD CONSTRAINT "in_person_order_employee_code_fkey" FOREIGN KEY ("employee_code") REFERENCES "employee"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "publisher_phone" ADD CONSTRAINT "publisher_phone_publisher_cnpj_fkey" FOREIGN KEY ("publisher_cnpj") REFERENCES "publisher"("cnpj") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "publisher_email" ADD CONSTRAINT "publisher_email_publisher_cnpj_fkey" FOREIGN KEY ("publisher_cnpj") REFERENCES "publisher"("cnpj") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book" ADD CONSTRAINT "book_publisher_cnpj_fkey" FOREIGN KEY ("publisher_cnpj") REFERENCES "publisher"("cnpj") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_author" ADD CONSTRAINT "book_author_book_code_fkey" FOREIGN KEY ("book_code") REFERENCES "book"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_category" ADD CONSTRAINT "book_category_book_code_fkey" FOREIGN KEY ("book_code") REFERENCES "book"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "copy" ADD CONSTRAINT "copy_book_code_fkey" FOREIGN KEY ("book_code") REFERENCES "book"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "online_order" ADD CONSTRAINT "online_order_order_number_fkey" FOREIGN KEY ("order_number") REFERENCES "order"("number") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_has_copy" ADD CONSTRAINT "order_has_copy_order_number_fkey" FOREIGN KEY ("order_number") REFERENCES "order"("number") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_has_copy" ADD CONSTRAINT "order_has_copy_copy_code_fkey" FOREIGN KEY ("copy_code") REFERENCES "copy"("code") ON DELETE RESTRICT ON UPDATE CASCADE;
