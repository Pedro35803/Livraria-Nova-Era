/*
  Warnings:

  - You are about to drop the column `customer_code` on the `order` table. All the data in the column will be lost.
  - Added the required column `client_code` to the `order` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "book" DROP CONSTRAINT "book_publisher_cnpj_fkey";

-- DropForeignKey
ALTER TABLE "book_author" DROP CONSTRAINT "book_author_book_code_fkey";

-- DropForeignKey
ALTER TABLE "book_category" DROP CONSTRAINT "book_category_book_code_fkey";

-- DropForeignKey
ALTER TABLE "copy" DROP CONSTRAINT "copy_book_code_fkey";

-- DropForeignKey
ALTER TABLE "in_person_order" DROP CONSTRAINT "in_person_order_employee_code_fkey";

-- DropForeignKey
ALTER TABLE "in_person_order" DROP CONSTRAINT "in_person_order_order_number_fkey";

-- DropForeignKey
ALTER TABLE "legal_client" DROP CONSTRAINT "legal_client_client_code_fkey";

-- DropForeignKey
ALTER TABLE "physical_client" DROP CONSTRAINT "physical_client_client_code_fkey";

-- DropForeignKey
ALTER TABLE "publisher_email" DROP CONSTRAINT "publisher_email_publisher_cnpj_fkey";

-- DropForeignKey
ALTER TABLE "publisher_phone" DROP CONSTRAINT "publisher_phone_publisher_cnpj_fkey";

-- AlterTable
ALTER TABLE "order" DROP COLUMN "customer_code",
ADD COLUMN     "client_code" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "physical_client" ADD CONSTRAINT "physical_client_client_code_fkey" FOREIGN KEY ("client_code") REFERENCES "client"("code") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "legal_client" ADD CONSTRAINT "legal_client_client_code_fkey" FOREIGN KEY ("client_code") REFERENCES "client"("code") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "in_person_order" ADD CONSTRAINT "in_person_order_order_number_fkey" FOREIGN KEY ("order_number") REFERENCES "order"("number") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "in_person_order" ADD CONSTRAINT "in_person_order_employee_code_fkey" FOREIGN KEY ("employee_code") REFERENCES "employee"("code") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "publisher_phone" ADD CONSTRAINT "publisher_phone_publisher_cnpj_fkey" FOREIGN KEY ("publisher_cnpj") REFERENCES "publisher"("cnpj") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "publisher_email" ADD CONSTRAINT "publisher_email_publisher_cnpj_fkey" FOREIGN KEY ("publisher_cnpj") REFERENCES "publisher"("cnpj") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book" ADD CONSTRAINT "book_publisher_cnpj_fkey" FOREIGN KEY ("publisher_cnpj") REFERENCES "publisher"("cnpj") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_author" ADD CONSTRAINT "book_author_book_code_fkey" FOREIGN KEY ("book_code") REFERENCES "book"("code") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_category" ADD CONSTRAINT "book_category_book_code_fkey" FOREIGN KEY ("book_code") REFERENCES "book"("code") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "copy" ADD CONSTRAINT "copy_book_code_fkey" FOREIGN KEY ("book_code") REFERENCES "book"("code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_client_code_fkey" FOREIGN KEY ("client_code") REFERENCES "client"("code") ON DELETE SET NULL ON UPDATE CASCADE;
