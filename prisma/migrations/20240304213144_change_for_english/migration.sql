/*
  Warnings:

  - You are about to drop the `cliente` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `clienteFisico` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `clienteJuridico` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `editora` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `emailEditora` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `exemplar` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `funcionario` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `livro` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `livroAutor` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `livroCategoria` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pedido` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pedidoOnline` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pedidoPresencial` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pedidoTemExemplar` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `telefoneEditora` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "clienteFisico" DROP CONSTRAINT "fk_clienteFisico";

-- DropForeignKey
ALTER TABLE "clienteJuridico" DROP CONSTRAINT "fk_clienteJuridico";

-- DropForeignKey
ALTER TABLE "emailEditora" DROP CONSTRAINT "fk_emailEditora";

-- DropForeignKey
ALTER TABLE "exemplar" DROP CONSTRAINT "fk_exemplar";

-- DropForeignKey
ALTER TABLE "livro" DROP CONSTRAINT "fk_livro";

-- DropForeignKey
ALTER TABLE "livroAutor" DROP CONSTRAINT "fk_livroAutor";

-- DropForeignKey
ALTER TABLE "livroCategoria" DROP CONSTRAINT "fk_livroCategoria";

-- DropForeignKey
ALTER TABLE "pedido" DROP CONSTRAINT "fk_pedido";

-- DropForeignKey
ALTER TABLE "pedidoOnline" DROP CONSTRAINT "fk_pedidoOnline";

-- DropForeignKey
ALTER TABLE "pedidoPresencial" DROP CONSTRAINT "fk_01_pedidoPresencial";

-- DropForeignKey
ALTER TABLE "pedidoPresencial" DROP CONSTRAINT "fk_02_pedidoPresencial";

-- DropForeignKey
ALTER TABLE "pedidoTemExemplar" DROP CONSTRAINT "fk_01_pedidoTemExemplar";

-- DropForeignKey
ALTER TABLE "pedidoTemExemplar" DROP CONSTRAINT "fk_02_pedidoTemExemplar";

-- DropForeignKey
ALTER TABLE "telefoneEditora" DROP CONSTRAINT "fk_telefoneEditora";

-- DropTable
DROP TABLE "cliente";

-- DropTable
DROP TABLE "clienteFisico";

-- DropTable
DROP TABLE "clienteJuridico";

-- DropTable
DROP TABLE "editora";

-- DropTable
DROP TABLE "emailEditora";

-- DropTable
DROP TABLE "exemplar";

-- DropTable
DROP TABLE "funcionario";

-- DropTable
DROP TABLE "livro";

-- DropTable
DROP TABLE "livroAutor";

-- DropTable
DROP TABLE "livroCategoria";

-- DropTable
DROP TABLE "pedido";

-- DropTable
DROP TABLE "pedidoOnline";

-- DropTable
DROP TABLE "pedidoPresencial";

-- DropTable
DROP TABLE "pedidoTemExemplar";

-- DropTable
DROP TABLE "telefoneEditora";

-- DropTable
DROP TABLE "user";

-- CreateTable
CREATE TABLE "User" (
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255),

    CONSTRAINT "pk_user" PRIMARY KEY ("email")
);

-- CreateTable
CREATE TABLE "Client" (
    "code" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email_01" VARCHAR(255) NOT NULL,
    "email_02" VARCHAR(255),
    "phone_01" CHAR(11) NOT NULL,
    "phone_02" CHAR(11),

    CONSTRAINT "pk_client" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "PhysicalClient" (
    "client_code" INTEGER NOT NULL,
    "rg" VARCHAR(50) NOT NULL,
    "cpf" CHAR(11) NOT NULL,

    CONSTRAINT "pk_physicalClient" PRIMARY KEY ("client_code")
);

-- CreateTable
CREATE TABLE "LegalClient" (
    "client_code" INTEGER NOT NULL,
    "cnpj" CHAR(14) NOT NULL,

    CONSTRAINT "pk_legalClient" PRIMARY KEY ("client_code")
);

-- CreateTable
CREATE TABLE "Publisher" (
    "cnpj" CHAR(14) NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "pk_publisher" PRIMARY KEY ("cnpj")
);

-- CreateTable
CREATE TABLE "PublisherEmail" (
    "cnpj_publisher" CHAR(14) NOT NULL,
    "email" VARCHAR(255) NOT NULL,

    CONSTRAINT "pk_publisherEmail" PRIMARY KEY ("email","cnpj_publisher")
);

-- CreateTable
CREATE TABLE "PublisherPhone" (
    "cnpj_publisher" CHAR(14) NOT NULL,
    "phone" CHAR(11) NOT NULL,

    CONSTRAINT "pk_publisherPhone" PRIMARY KEY ("phone","cnpj_publisher")
);

-- CreateTable
CREATE TABLE "Employee" (
    "code" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "salary" DOUBLE PRECISION NOT NULL,
    "hiring_year" DATE NOT NULL,

    CONSTRAINT "pk_employee" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "Book" (
    "code" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "release_year" CHAR(4) NOT NULL,
    "cnpj_publisher" CHAR(14),

    CONSTRAINT "pk_book" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "BookAuthor" (
    "code_book" INTEGER NOT NULL,
    "author" VARCHAR(255) NOT NULL,

    CONSTRAINT "pk_bookAuthor" PRIMARY KEY ("author","code_book")
);

-- CreateTable
CREATE TABLE "BookCategory" (
    "code_book" INTEGER NOT NULL,
    "category" VARCHAR(50) NOT NULL,

    CONSTRAINT "pk_bookCategory" PRIMARY KEY ("category","code_book")
);

-- CreateTable
CREATE TABLE "Copy" (
    "code" INTEGER NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "code_book" INTEGER,

    CONSTRAINT "pk_copy" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "Order" (
    "number" INTEGER NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "date" TIMESTAMP(6) NOT NULL,
    "payment_method" VARCHAR(50) NOT NULL,
    "client_code" INTEGER,

    CONSTRAINT "pk_order" PRIMARY KEY ("number")
);

-- CreateTable
CREATE TABLE "OrderOnline" (
    "order_number" INTEGER NOT NULL,
    "zip" VARCHAR(50) NOT NULL,
    "state" VARCHAR(255) NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "street" VARCHAR(255) NOT NULL,
    "number" VARCHAR(15) NOT NULL,
    "length" VARCHAR(255),

    CONSTRAINT "pk_orderOnline" PRIMARY KEY ("order_number")
);

-- CreateTable
CREATE TABLE "PhysicalOrder" (
    "order_number" INTEGER NOT NULL,
    "code_employee" INTEGER,

    CONSTRAINT "pk_physicalOrder" PRIMARY KEY ("order_number")
);

-- CreateTable
CREATE TABLE "OrderHasCopy" (
    "id" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "order_number" INTEGER,
    "code_copy" INTEGER,

    CONSTRAINT "pk_orderHasCopy" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "index_client" ON "Client"("code");

-- CreateIndex
CREATE UNIQUE INDEX "PhysicalClient_rg_key" ON "PhysicalClient"("rg");

-- CreateIndex
CREATE UNIQUE INDEX "PhysicalClient_cpf_key" ON "PhysicalClient"("cpf");

-- CreateIndex
CREATE INDEX "index_physicalClient" ON "PhysicalClient"("client_code");

-- CreateIndex
CREATE UNIQUE INDEX "LegalClient_cnpj_key" ON "LegalClient"("cnpj");

-- CreateIndex
CREATE INDEX "index_legalClient" ON "LegalClient"("client_code");

-- CreateIndex
CREATE INDEX "index_publisher" ON "Publisher"("cnpj");

-- CreateIndex
CREATE INDEX "index_publisherEmail" ON "PublisherEmail"("cnpj_publisher");

-- CreateIndex
CREATE INDEX "index_publisherPhone" ON "PublisherPhone"("cnpj_publisher");

-- CreateIndex
CREATE INDEX "index_employee" ON "Employee"("code");

-- CreateIndex
CREATE INDEX "index_book" ON "Book"("code");

-- CreateIndex
CREATE INDEX "index_bookAuthor" ON "BookAuthor"("code_book");

-- CreateIndex
CREATE INDEX "index_bookCategory" ON "BookCategory"("code_book");

-- CreateIndex
CREATE INDEX "index_copy" ON "Copy"("code");

-- CreateIndex
CREATE INDEX "index_order" ON "Order"("number");

-- CreateIndex
CREATE INDEX "index_orderOnline" ON "OrderOnline"("order_number");

-- CreateIndex
CREATE INDEX "index_physicalOrder" ON "PhysicalOrder"("order_number");

-- CreateIndex
CREATE INDEX "index_orderHasCopy" ON "OrderHasCopy"("id");

-- AddForeignKey
ALTER TABLE "PhysicalClient" ADD CONSTRAINT "fk_physicalClient" FOREIGN KEY ("client_code") REFERENCES "Client"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "LegalClient" ADD CONSTRAINT "fk_legalClient" FOREIGN KEY ("client_code") REFERENCES "Client"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "PublisherEmail" ADD CONSTRAINT "fk_publisherEmail" FOREIGN KEY ("cnpj_publisher") REFERENCES "Publisher"("cnpj") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "PublisherPhone" ADD CONSTRAINT "fk_publisherPhone" FOREIGN KEY ("cnpj_publisher") REFERENCES "Publisher"("cnpj") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "fk_book" FOREIGN KEY ("cnpj_publisher") REFERENCES "Publisher"("cnpj") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "BookAuthor" ADD CONSTRAINT "fk_bookAuthor" FOREIGN KEY ("code_book") REFERENCES "Book"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "BookCategory" ADD CONSTRAINT "fk_bookCategory" FOREIGN KEY ("code_book") REFERENCES "Book"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Copy" ADD CONSTRAINT "fk_copy" FOREIGN KEY ("code_book") REFERENCES "Book"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "fk_order" FOREIGN KEY ("client_code") REFERENCES "Client"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "OrderOnline" ADD CONSTRAINT "fk_orderOnline" FOREIGN KEY ("order_number") REFERENCES "Order"("number") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "PhysicalOrder" ADD CONSTRAINT "fk_01_physicalOrder" FOREIGN KEY ("order_number") REFERENCES "Order"("number") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "PhysicalOrder" ADD CONSTRAINT "fk_02_physicalOrder" FOREIGN KEY ("code_employee") REFERENCES "Employee"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "OrderHasCopy" ADD CONSTRAINT "fk_01_orderHasCopy" FOREIGN KEY ("order_number") REFERENCES "Order"("number") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "OrderHasCopy" ADD CONSTRAINT "fk_02_orderHasCopy" FOREIGN KEY ("code_copy") REFERENCES "Copy"("code") ON DELETE NO ACTION ON UPDATE NO ACTION;
