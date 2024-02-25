-- CreateTable
CREATE TABLE "client" (
    "code" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email_01" TEXT NOT NULL,
    "email_02" TEXT,
    "phone_01" TEXT NOT NULL,
    "phone_02" TEXT,

    CONSTRAINT "client_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "physical_client" (
    "client_code" SERIAL NOT NULL,
    "cpf" TEXT NOT NULL,
    "rg" TEXT NOT NULL,

    CONSTRAINT "physical_client_pkey" PRIMARY KEY ("client_code")
);

-- CreateTable
CREATE TABLE "legal_client" (
    "client_code" SERIAL NOT NULL,
    "cnpj" TEXT NOT NULL,

    CONSTRAINT "legal_client_pkey" PRIMARY KEY ("client_code")
);

-- CreateTable
CREATE TABLE "order" (
    "number" SERIAL NOT NULL,
    "status" TEXT NOT NULL,
    "payment_method" TEXT NOT NULL,
    "customer_code" INTEGER,

    CONSTRAINT "order_pkey" PRIMARY KEY ("number")
);

-- CreateTable
CREATE TABLE "online_order" (
    "order_number" SERIAL NOT NULL,
    "zip_code" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "street" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "complement" TEXT,

    CONSTRAINT "online_order_pkey" PRIMARY KEY ("order_number")
);

-- CreateTable
CREATE TABLE "employee" (
    "code" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "in_person_order" (
    "order_number" SERIAL NOT NULL,
    "employee_code" INTEGER,

    CONSTRAINT "in_person_order_pkey" PRIMARY KEY ("order_number")
);

-- CreateTable
CREATE TABLE "publisher" (
    "cnpj" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "publisher_pkey" PRIMARY KEY ("cnpj")
);

-- CreateTable
CREATE TABLE "publisher_phone" (
    "publisher_cnpj" TEXT NOT NULL,
    "phone" TEXT,

    CONSTRAINT "publisher_phone_pkey" PRIMARY KEY ("publisher_cnpj")
);

-- CreateTable
CREATE TABLE "publisher_email" (
    "publisher_cnpj" TEXT NOT NULL,
    "email" TEXT,

    CONSTRAINT "publisher_email_pkey" PRIMARY KEY ("publisher_cnpj")
);

-- CreateTable
CREATE TABLE "book" (
    "code" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "release_year" TEXT NOT NULL,
    "publisher_cnpj" TEXT,

    CONSTRAINT "book_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "book_author" (
    "book_code" SERIAL NOT NULL,
    "author" TEXT NOT NULL,

    CONSTRAINT "book_author_pkey" PRIMARY KEY ("book_code")
);

-- CreateTable
CREATE TABLE "book_category" (
    "book_code" SERIAL NOT NULL,
    "category" TEXT,

    CONSTRAINT "book_category_pkey" PRIMARY KEY ("book_code")
);

-- CreateTable
CREATE TABLE "copy" (
    "code" SERIAL NOT NULL,
    "status" TEXT NOT NULL,
    "book_code" INTEGER,

    CONSTRAINT "copy_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "order_has_copy" (
    "id" SERIAL NOT NULL,
    "order_number" INTEGER,
    "copy_code" INTEGER,

    CONSTRAINT "order_has_copy_pkey" PRIMARY KEY ("id")
);
