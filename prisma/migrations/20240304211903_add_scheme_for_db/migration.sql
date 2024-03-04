-- CreateTable
CREATE TABLE "user" (
    "email" VARCHAR(255) NOT NULL,
    "senha" VARCHAR(255) NOT NULL,
    "nome" VARCHAR(255),

    CONSTRAINT "pk_user" PRIMARY KEY ("email")
);

-- CreateTable
CREATE TABLE "cliente" (
    "codigo" INTEGER NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "email_01" VARCHAR(255) NOT NULL,
    "email_02" VARCHAR(255),
    "telefone_01" CHAR(11) NOT NULL,
    "telefone_02" CHAR(11),

    CONSTRAINT "pk_cliente" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "clienteFisico" (
    "codigo_cliente" INTEGER NOT NULL,
    "rg" VARCHAR(50) NOT NULL,
    "cpf" CHAR(11) NOT NULL,

    CONSTRAINT "pk_clienteFisico" PRIMARY KEY ("codigo_cliente")
);

-- CreateTable
CREATE TABLE "clienteJuridico" (
    "codigo_cliente" INTEGER NOT NULL,
    "cnpj" CHAR(14) NOT NULL,

    CONSTRAINT "pk_clienteJuridico" PRIMARY KEY ("codigo_cliente")
);

-- CreateTable
CREATE TABLE "editora" (
    "cnpj" CHAR(14) NOT NULL,
    "nome" VARCHAR(255) NOT NULL,

    CONSTRAINT "pk_editora" PRIMARY KEY ("cnpj")
);

-- CreateTable
CREATE TABLE "emailEditora" (
    "cnpj_editora" CHAR(14) NOT NULL,
    "email" VARCHAR(255) NOT NULL,

    CONSTRAINT "pk_emailEditora" PRIMARY KEY ("email","cnpj_editora")
);

-- CreateTable
CREATE TABLE "telefoneEditora" (
    "cnpj_editora" CHAR(14) NOT NULL,
    "telefone" CHAR(11) NOT NULL,

    CONSTRAINT "pk_telefoneEditora" PRIMARY KEY ("telefone","cnpj_editora")
);

-- CreateTable
CREATE TABLE "funcionario" (
    "codigo" INTEGER NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "salario" DOUBLE PRECISION NOT NULL,
    "ano_de_admissao" DATE NOT NULL,

    CONSTRAINT "pk_funcionario" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "livro" (
    "codigo" INTEGER NOT NULL,
    "titulo" VARCHAR(255) NOT NULL,
    "preco" DOUBLE PRECISION NOT NULL,
    "ano_de_lancamento" CHAR(4) NOT NULL,
    "cnpj_editora" CHAR(14),

    CONSTRAINT "pk_livro" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "livroAutor" (
    "codigo_livro" INTEGER NOT NULL,
    "autor" VARCHAR(255) NOT NULL,

    CONSTRAINT "pk_livroAutor" PRIMARY KEY ("autor","codigo_livro")
);

-- CreateTable
CREATE TABLE "livroCategoria" (
    "codigo_livro" INTEGER NOT NULL,
    "categoria" VARCHAR(50) NOT NULL,

    CONSTRAINT "pk_livroCategoria" PRIMARY KEY ("categoria","codigo_livro")
);

-- CreateTable
CREATE TABLE "exemplar" (
    "codigo" INTEGER NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "codigo_livro" INTEGER,

    CONSTRAINT "pk_exemplar" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "pedido" (
    "numero" INTEGER NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "data" TIMESTAMP(6) NOT NULL,
    "forma_de_pagamento" VARCHAR(50) NOT NULL,
    "codigo_cliente" INTEGER,

    CONSTRAINT "pk_pedido" PRIMARY KEY ("numero")
);

-- CreateTable
CREATE TABLE "pedidoOnline" (
    "numero_pedido" INTEGER NOT NULL,
    "cep" VARCHAR(50) NOT NULL,
    "estado" VARCHAR(255) NOT NULL,
    "cidade" VARCHAR(255) NOT NULL,
    "rua" VARCHAR(255) NOT NULL,
    "numero" VARCHAR(15) NOT NULL,
    "compremento" VARCHAR(255),

    CONSTRAINT "pk_pedidoOnline" PRIMARY KEY ("numero_pedido")
);

-- CreateTable
CREATE TABLE "pedidoPresencial" (
    "numero_pedido" INTEGER NOT NULL,
    "codigo_funcionario" INTEGER,

    CONSTRAINT "pk_pedidoPresencial" PRIMARY KEY ("numero_pedido")
);

-- CreateTable
CREATE TABLE "pedidoTemExemplar" (
    "id" INTEGER NOT NULL,
    "preco" DOUBLE PRECISION NOT NULL,
    "numero_pedido" INTEGER,
    "codigo_exemplar" INTEGER,

    CONSTRAINT "pk_pedidoTemExemplar" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "index_cliente" ON "cliente"("codigo");

-- CreateIndex
CREATE UNIQUE INDEX "clienteFisico_rg_key" ON "clienteFisico"("rg");

-- CreateIndex
CREATE UNIQUE INDEX "clienteFisico_cpf_key" ON "clienteFisico"("cpf");

-- CreateIndex
CREATE INDEX "index_clienteFisico" ON "clienteFisico"("codigo_cliente");

-- CreateIndex
CREATE UNIQUE INDEX "clienteJuridico_cnpj_key" ON "clienteJuridico"("cnpj");

-- CreateIndex
CREATE INDEX "index_clienteJuridico" ON "clienteJuridico"("codigo_cliente");

-- CreateIndex
CREATE INDEX "index_editora" ON "editora"("cnpj");

-- CreateIndex
CREATE INDEX "index_emailEditora" ON "emailEditora"("cnpj_editora");

-- CreateIndex
CREATE INDEX "index_telefoneEditora" ON "telefoneEditora"("cnpj_editora");

-- CreateIndex
CREATE INDEX "index_funcionario" ON "funcionario"("codigo");

-- CreateIndex
CREATE INDEX "index_livro" ON "livro"("codigo");

-- CreateIndex
CREATE INDEX "index_livroAutor" ON "livroAutor"("codigo_livro");

-- CreateIndex
CREATE INDEX "index_livroCategoria" ON "livroCategoria"("codigo_livro");

-- CreateIndex
CREATE INDEX "index_exemplar" ON "exemplar"("codigo");

-- CreateIndex
CREATE INDEX "index_pedido" ON "pedido"("numero");

-- CreateIndex
CREATE INDEX "index_pedidoOnline" ON "pedidoOnline"("numero_pedido");

-- CreateIndex
CREATE INDEX "index_pedidoPresencial" ON "pedidoPresencial"("numero_pedido");

-- CreateIndex
CREATE INDEX "index_pedidoTemExemplar" ON "pedidoTemExemplar"("id");

-- AddForeignKey
ALTER TABLE "clienteFisico" ADD CONSTRAINT "fk_clienteFisico" FOREIGN KEY ("codigo_cliente") REFERENCES "cliente"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "clienteJuridico" ADD CONSTRAINT "fk_clienteJuridico" FOREIGN KEY ("codigo_cliente") REFERENCES "cliente"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "emailEditora" ADD CONSTRAINT "fk_emailEditora" FOREIGN KEY ("cnpj_editora") REFERENCES "editora"("cnpj") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "telefoneEditora" ADD CONSTRAINT "fk_telefoneEditora" FOREIGN KEY ("cnpj_editora") REFERENCES "editora"("cnpj") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "livro" ADD CONSTRAINT "fk_livro" FOREIGN KEY ("cnpj_editora") REFERENCES "editora"("cnpj") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "livroAutor" ADD CONSTRAINT "fk_livroAutor" FOREIGN KEY ("codigo_livro") REFERENCES "livro"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "livroCategoria" ADD CONSTRAINT "fk_livroCategoria" FOREIGN KEY ("codigo_livro") REFERENCES "livro"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "exemplar" ADD CONSTRAINT "fk_exemplar" FOREIGN KEY ("codigo_livro") REFERENCES "livro"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedido" ADD CONSTRAINT "fk_pedido" FOREIGN KEY ("codigo_cliente") REFERENCES "cliente"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidoOnline" ADD CONSTRAINT "fk_pedidoOnline" FOREIGN KEY ("numero_pedido") REFERENCES "pedido"("numero") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidoPresencial" ADD CONSTRAINT "fk_01_pedidoPresencial" FOREIGN KEY ("numero_pedido") REFERENCES "pedido"("numero") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidoPresencial" ADD CONSTRAINT "fk_02_pedidoPresencial" FOREIGN KEY ("codigo_funcionario") REFERENCES "funcionario"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidoTemExemplar" ADD CONSTRAINT "fk_01_pedidoTemExemplar" FOREIGN KEY ("numero_pedido") REFERENCES "pedido"("numero") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidoTemExemplar" ADD CONSTRAINT "fk_02_pedidoTemExemplar" FOREIGN KEY ("codigo_exemplar") REFERENCES "exemplar"("codigo") ON DELETE NO ACTION ON UPDATE NO ACTION;
