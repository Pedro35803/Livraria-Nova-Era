-- Criando Tabelas do Banco de Dados

CREATE TABLE Cliente (
	Codigo INT,
	Nome VARCHAR(255) NOT NULL,
	Email_01 VARCHAR(255) NOT NULL,
	Email_02 VARCHAR(255),
	Telefone_01 CHARACTER(11) NOT NULL,
	Telefone_02 CHARACTER(11),
	CONSTRAINT PK_Cliente PRIMARY KEY (Codigo)
);

CREATE TABLE ClienteFisico (
	CodigoCliente INT,
	RG VARCHAR(50) UNIQUE NOT NULL,
	CPF CHARACTER(11) UNIQUE NOT NULL,
	CONSTRAINT PK_ClienteFisico PRIMARY KEY (CodigoCliente),
	CONSTRAINT FK_ClienteFisico FOREIGN KEY (CodigoCliente) REFERENCES Cliente(Codigo)
);

CREATE TABLE ClienteJuridico (
	CodigoCliente INT,
	CNPJ CHARACTER(14) UNIQUE NOT NULL,
	CONSTRAINT PK_ClienteJuridico PRIMARY KEY (CodigoCliente),
	CONSTRAINT FK_ClienteJuridico FOREIGN KEY (CodigoCliente) REFERENCES Cliente(Codigo)
);

CREATE TABLE Pedido (
	Numero INT,
	Status VARCHAR(50) NOT NULL,
	Valor DOUBLE PRECISION NOT NULL,
	Data TIMESTAMP NOT NULL,
	Forma_de_Pagamento VARCHAR(50) NOT NULL,
	CodigoCliente INT,
	CONSTRAINT PK_Pedido PRIMARY KEY (Numero),
	CONSTRAINT FK_Pedido FOREIGN KEY (CodigoCliente) REFERENCES Cliente(Codigo)
);

CREATE TABLE PedidoOnline (
	NumeroPedido INT,
	CEP VARCHAR(50) NOT NULL,
	Estado VARCHAR(255) NOT NULL,
	Cidade VARCHAR(255) NOT NULL,
	Rua VARCHAR(255) NOT NULL,
	Numero VARCHAR(15) NOT NULL,
	Compremento VARCHAR(255),
	CONSTRAINT PK_PedidoOnline PRIMARY KEY (NumeroPedido),
	CONSTRAINT FK_PedidoOnline FOREIGN KEY (NumeroPedido) REFERENCES Pedido(Numero)
);

CREATE TABLE Funcionario (
	Codigo INT,
	Nome VARCHAR(255) NOT NULL,
	Salario DOUBLE PRECISION NOT NULL,
	Ano_de_Admissao DATE NOT NULL,
	CONSTRAINT PK_Funcionario PRIMARY KEY (Codigo),
    CONSTRAINT Salario_Positivo_Funcionario CHECK (0 < Salario)
);

CREATE TABLE PedidoPresencial (
	NumeroPedido INT,
	CodigoFuncionario INT,
	CONSTRAINT PK_PedidoPresencial PRIMARY KEY (NumeroPedido),
	CONSTRAINT FK_01_PedidoPresencial FOREIGN KEY (NumeroPedido) REFERENCES Pedido(Numero),
	CONSTRAINT FK_02_PedidoPresencial FOREIGN KEY (CodigoFuncionario) REFERENCES Funcionario(Codigo)
);

CREATE TABLE Editora (
    CNPJ CHARACTER(14),
    Nome VARCHAR(255) NOT NULL,
	CONSTRAINT PK_Editora PRIMARY KEY (CNPJ)
);

CREATE TABLE TelefoneEditora (
    CNPJEditora CHARACTER(14),
    Telefone CHARACTER(11),
    CONSTRAINT PK_TelefoneEditora PRIMARY KEY (Telefone, CNPJEditora),
	CONSTRAINT FK_TelefoneEditora FOREIGN KEY (CNPJEditora) REFERENCES Editora(CNPJ)
);

CREATE TABLE EmailEditora (
    CNPJEditora CHARACTER(14),
    Email VARCHAR(255),
    CONSTRAINT PK_EmailEditora PRIMARY KEY (Email, CNPJEditora),
	CONSTRAINT FK_EmailEditora FOREIGN KEY (CNPJEditora) REFERENCES Editora(CNPJ)
);

CREATE TABLE Livro (
	Codigo INT,
    Titulo VARCHAR(255) NOT NULL,
    Preco DOUBLE PRECISION NOT NULL,
    Ano_de_Lancamento CHARACTER(4) NOT NULL,
    CNPJEditora CHARACTER(14),
	CONSTRAINT PK_Livro PRIMARY KEY (Codigo),
	CONSTRAINT FK_Livro FOREIGN KEY (CNPJEditora) REFERENCES Editora(CNPJ),
    CONSTRAINT Preco_Positivo_Livro CHECK (0 < preco)
);

CREATE TABLE LivroAutor (
    CodigoLivro INT,
    Autor VARCHAR(255) NOT NULL,
    CONSTRAINT PK_LivroAutor PRIMARY KEY (Autor, CodigoLivro),
	CONSTRAINT FK_LivroAutor FOREIGN KEY (CodigoLivro) REFERENCES Livro(Codigo)
);

CREATE TABLE LivroCategoria (
    CodigoLivro INT,
    Categoria VARCHAR(50),
    CONSTRAINT PK_LivroCategoria PRIMARY KEY (Categoria, CodigoLivro),
	CONSTRAINT FK_LivroCategoria FOREIGN KEY (CodigoLivro) REFERENCES Livro(Codigo)
);

CREATE TABLE Exemplar (
	Codigo INT,
    Status VARCHAR(50) NOT NULL,
    CodigoLivro INT,
	CONSTRAINT PK_Exemplar PRIMARY KEY (Codigo),
    CONSTRAINT FK_Exemplar FOREIGN KEY (CodigoLivro) REFERENCES Livro(Codigo)
);

CREATE TABLE PedidoTemExemplar (
    Id INT,
    Preco DOUBLE PRECISION NOT NULL,
    NumeroPedido INT,
    CodigoExemplar INT,
	CONSTRAINT PK_PedidoTemExemplar PRIMARY KEY (Id),
    CONSTRAINT FK_01_PedidoTemExemplar FOREIGN KEY (NumeroPedido) REFERENCES Pedido(Numero),
	CONSTRAINT FK_02_PedidoTemExemplar FOREIGN KEY (CodigoExemplar) REFERENCES Exemplar(Codigo),
    CONSTRAINT Preco_Positivo_PedidoTemExemplar CHECK (0 < preco)
);


-- Povoando tabelas

-- Povoando tuplas de Cliente

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (1, 'Vanessa Barher Pereira Silvino', 'vanessa@gmail.com', null, '11975305249', '11995550524');

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (2, 'Carlos Marotti Rios Nazare', 'carlos909@gmail.com', null, '89925571883', null);

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (3, 'Matheus Rangel Baesso Chaves', 'matheus55@gmail.com', 'matheus55@hotmail.com', '92921627417', '92939230862');

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (4, 'Miguel Malaquias Dores Pinho', 'miguel77@gmail.com', 'miguel77@hotmail.com', '83938687338', null);

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (5, 'Humberto Paiva Mendonça Carmo', 'humberto3@gmail.com', null, '83927388577', null);

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (6, 'Spilman Macedo Contabilidade ME', 'compras@contabilidade.spilman.com.br', 'controle.compras@contabilidade.spilman.com.br', '81934220121', '81987857785');

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (7, 'Bueno Freitas Advocacia ME', 'compras@dvocacia.buenofreitas.com.br', 'controle.compras@dvocacia.buenofreitas.com.br', '92929436740', '97985017500');

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (8, 'Thomaz Navega Empreendimentos EPP', 'compras@empreendimentos.thomaznavega.com.br', 'controle.compras@empreendimentos.thomaznavega.com.br', '69934464125', '69980512885');

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (9, 'Rosa Falcão Planejamento EPP', 'compras@planejamento.rosafalcão.com.br', 'controle.compras@planejamento.rosafalcão.com.br', '15924716609', '16995714825');

INSERT INTO Cliente (codigo, nome, email_01, email_02, telefone_01, telefone_02) VALUES (10, 'Cunha Theodoro Consultoria LTDA', 'compras@consultoria.cunhatheodoro.com.br', 'controle.compras@consultoria.cunhatheodoro.com.br', '82932942597', '8280284778');

-- Povoando tuplas de ClienteFisico

INSERT INTO ClienteFisico (CodigoCliente, RG, CPF) values (1, '414205200', '11475773820');
INSERT INTO ClienteFisico (CodigoCliente, RG, CPF) values (2, '318817433', '66070253385');
INSERT INTO ClienteFisico (CodigoCliente, RG, CPF) values (3, '216815647', '85636138202');
INSERT INTO ClienteFisico (CodigoCliente, RG, CPF) values (4, '327925681', '52871215472');
INSERT INTO ClienteFisico (CodigoCliente, RG, CPF) values (5, '159548287', '31838288473');

-- Povoando tuplas de ClienteJuridico

INSERT INTO ClienteJuridico (CodigoCliente, CNPJ) values (6, '81025286000161');
INSERT INTO ClienteJuridico (CodigoCliente, CNPJ) values (7, '53890177000177');
INSERT INTO ClienteJuridico (CodigoCliente, CNPJ) values (8, '74860373000179');
INSERT INTO ClienteJuridico (CodigoCliente, CNPJ) values (9, '11451105000183');
INSERT INTO ClienteJuridico (CodigoCliente, CNPJ) values (10, '07019562000126');

-- Povoando tuplas de Funcionarios

insert into funcionario (Codigo, Nome, Salario, Ano_de_Admissao) values (1, 'Isaías Feijó Azevedo', 1300, '05-09-2018');

insert into funcionario (Codigo, Nome, Salario, Ano_de_Admissao) values (2, 'Ranya Franqueira Raminhos', 1300, '12-08-2018');

insert into funcionario (Codigo, Nome, Salario, Ano_de_Admissao) values (3, 'Ravi Aranha Frade', 1450, '25-11-2016');

insert into funcionario (Codigo, Nome, Salario, Ano_de_Admissao) values (4, 'Rodrigo Covilhã Mourão', 1150, '16-02-2018');

insert into funcionario (Codigo, Nome, Salario, Ano_de_Admissao) values (5, 'Pietro Póvoas Feijó', 1300, '07-06-2021');

-- Povoando tuplas de Editora

INSERT INTO Editora (CNPJ, Nome) values ('45365284015101', 'Saraiva');
INSERT INTO Editora (CNPJ, Nome) values ('52322826099407', 'Companhia da Letras');
INSERT INTO Editora (CNPJ, Nome) values ('61372276809708', 'FTD');
INSERT INTO Editora (CNPJ, Nome) values ('11382676909013', 'Leya');
INSERT INTO Editora (CNPJ, Nome) values ('91686776006807', 'Editora Arqueiro');

-- Povoando tuplas de EmailEditora

INSERT INTO EmailEditora (CNPJEditora, Email) values ('45365284015101', 'www.saraiva.com.br/ajuda');
INSERT INTO EmailEditora (CNPJEditora, Email) values ('45365284015101', 'sac@saraiva.com.br');
INSERT INTO EmailEditora (CNPJEditora, Email) values ('45365284015101', 'vendas@saraiva.com.br');

INSERT INTO EmailEditora (CNPJEditora, Email) values ('52322826099407', 'sac@companhiadasletras.com.br,');
INSERT INTO EmailEditora (CNPJEditora, Email) values ('52322826099407', 'vendas@companhiadasletras.com.br,');

INSERT INTO EmailEditora (CNPJEditora, Email) values ('61372276809708', 'central.atendimento@ftd.com.br');

INSERT INTO EmailEditora (CNPJEditora, Email) values ('11382676909013', 'sac@leyabrasil.com.br');
INSERT INTO EmailEditora (CNPJEditora, Email) values ('11382676909013', 'vendas@leyabrasil.com.br');

INSERT INTO EmailEditora (CNPJEditora, Email) values ('91686776006807', 'atendimento@editoraarqueiro.com.br');

-- Povoando tuplas de TelefoneEditora

INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('45365284015101', '89937450393');
INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('45365284015101', '98935655148');
INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('45365284015101', '85938263723');

INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('52322826099407', '73920601359');
INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('52322826099407', '64938913128');

INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('61372276809708', '83932528242');

INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('11382676909013', '61931228675');
INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('11382676909013', '79925674094');
INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('11382676909013', '67933477969');

INSERT INTO TelefoneEditora (CNPJEditora, Telefone) values ('91686776006807', '53921858244');

-- Povoando tuplas de Livro

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('1', 'ASSIM FALOU ZARATUSTRA', 37.90, 2018,'52322826099407');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('2', 'Teoria Geral do Direito', 54.95, 2019,'45365284015101');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('3', 'Lula', 47.99, 2021,'52322826099407');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('4', 'Os Miseráveis', 37.90, 1970,'61372276809708');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('5', 'O guia do mochileiro das galáxias', 30.99, 2007,'91686776006807');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('6', 'A Guerra dos Tronos : As Crônicas de Gelo e Fogo', 57.90, 2019,'11382676909013');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('7', 'A fúria dos reis: As Crônicas de Gelo e Fogo', 58.89, 2019,'11382676909013');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('8', 'A tormenta de espadas: As Crônicas de Gelo e Fogo', 61.95, 2019,'11382676909013');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('9', 'Sapiens (Nova edição): Uma breve história da humanidade', 4553, 2020,'52322826099407');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('10', 'O MUNDO DE SOFIA', 64.99, 2019,'52322826099407');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('11', 'Genealogia da moral ', 37.85, 2012,'52322826099407');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('12', 'A gaia ciência ', 20.81, 2012,'52322826099407');

INSERT INTO Livro (Codigo, Titulo, Preco, Ano_de_Lancamento, CNPJEditora ) values ('13', 'Freud (1901) - Obras completas volume 5: Psicopatologia da vida cotidiana e Sobre os sonhos ', 57.87, 2021,'52322826099407');

-- Povoando tuplas de LivroAutor

INSERT INTO LivroAutor (CodigoLivro, Autor) values (1, 'Friedrich Wilhelm Nietzsche');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (2, 'Ricardo Mauricio Freire Soares');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (3, 'Fernando Morais');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (4, 'Victor Hugo');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (5, 'Douglas Adams');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (6, 'George R. R. Martin');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (7, 'George R. R. Martin');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (8, 'George R. R. Martin');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (9, 'Yuval Harari');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (10, 'Jostein Gaarder');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (11, 'Friedrich Wilhelm Nietzsche');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (12, 'Friedrich Wilhelm Nietzsche');

INSERT INTO LivroAutor (CodigoLivro, Autor) values (13, 'Sigmund Freud');

-- Povoando tuplas de LivroCategoria

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (1, 'Filosofia');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (2, 'Juridico');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (3, 'Biografia');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (4, 'Romance');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (5, 'Ficção Científica');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (6, 'Fantasia Histórica');
INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (6, 'Romance');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (7, 'Fantasia Histórica');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (8, 'Fantasia Histórica');
INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (8, 'Romance');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (9, 'Livros de História da Civilização e Cultura');
INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (9, 'Ciencias');
INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (9, 'Biologia');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (10, 'Ficção Literária Literatura e Ficção');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (11, 'Filosofia');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (12, 'Filosofia');

INSERT INTO LivroCategoria (CodigoLivro, Categoria) values (13, 'Psicanálise');

-- Povoando tuplas de Exemplar

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 1, 'Disponivel', 1);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 2, 'Disponivel', 1);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 3, 'Disponivel', 1);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 4, 'Disponivel', 1);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 5, 'Indisponivel', 1);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 6, 'Indisponivel', 1);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 7, 'Disponivel', 2);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 8, 'Disponivel', 2);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 9, 'Disponivel', 2);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 10, 'Disponivel', 2);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 11, 'Indisponivel', 2);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 12, 'Disponivel', 2);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 13, 'Disponivel', 2);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 14, 'Disponivel', 3);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 15, 'Disponivel', 3);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 16, 'Disponivel', 3);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 17, 'Indisponivel', 3);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 18, 'Disponivel', 4);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 19, 'Disponivel', 4);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 20, 'Indisponivel', 4);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 21, 'Disponivel', 5);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 22, 'Disponivel', 5);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 23, 'Indisponivel', 5);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 24, 'Disponivel',5);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 25, 'Disponivel', 6);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 26, 'Disponivel', 6);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 27, 'Disponivel', 6);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 28, 'Indisponivel', 6);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 29, 'Disponivel', 6);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 30, 'Disponivel', 7);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 31, 'Disponivel', 7);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 32, 'Disponivel', 7);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 33, 'Indisponivel', 7);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 35, 'Disponivel', 8);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 36, 'Disponivel', 8);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 37, 'Indisponivel', 8);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 38, 'Disponivel', 9);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 39, 'Disponivel', 9);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 40, 'Indisponivel', 9);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 41, 'Disponivel', 10);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 42, 'Disponivel', 10);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 43, 'Indisponivel', 10);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 44, 'Disponivel', 11);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 45, 'Disponivel', 11);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 46, 'Indisponivel', 11);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 47, 'Disponivel', 12);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 48, 'Disponivel', 12);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 49, 'Disponivel', 12);

INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 50, 'Disponivel', 13);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 51, 'Disponivel', 13);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 52, 'Indisponivel', 13);
INSERT INTO Exemplar (Codigo, Status, CodigoLivro ) values ( 53, 'Disponivel', 13);

-- Povoando tuplas Pedido

INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (1, 'Em andamento', 75.8, '2019-07-02 05:58:06', 'Cartão', 1);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (2, 'Em andamento', 178.74, '2022-01-07 07:37:00', 'Cartão', 7);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (3, 'Entregue', 37.9, '2000-03-30 08:02:12', 'Cartão', 10);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (4, 'Entregue', 47.99, '2022-06-01 13:48:54', 'Cartão', 9);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (5, 'Em andamento', 64.99, '2003-09-14 15:15:55', 'Cartão', 3);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (6, 'Entregue', 37.85, '2015-08-14 16:28:30', 'Dinheiro', 2);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (7, 'Entregue', 57.87, '2022-08-31 17:03:10', 'Cartão', 5);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (8, 'Entregue', 30.99, '2007-03-30 17:07:01', 'Cartão', 6);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (9, 'Entregue', 45.53, '2021-12-31 21:39:47', 'Dinheiro', 4);
INSERT INTO Pedido (Numero, Status, Valor, Data, Forma_de_pagamento, CodigoCliente) VALUES (10, 'Entregue', 54.95, '2019-12-31 23:09:00', 'Dinheiro', 8);

-- Povoando tuplas PedidoPresencial

INSERT INTO PedidoPresencial (NumeroPedido, CodigoFuncionario) VALUES (4, 1);
INSERT INTO PedidoPresencial (NumeroPedido, CodigoFuncionario) VALUES (6, 3);
INSERT INTO PedidoPresencial (NumeroPedido, CodigoFuncionario) VALUES (8, 5);
INSERT INTO PedidoPresencial (NumeroPedido, CodigoFuncionario) VALUES (9, 4);
INSERT INTO PedidoPresencial (NumeroPedido, CodigoFuncionario) VALUES (10, 1);

-- Povoando tuplas PedidoOnline

INSERT INTO PedidoOnline (NumeroPedido, Cep, Estado, Cidade, Rua, Numero, Compremento) VALUES (1, '95146-924', 'Sergipe', 'Mossoró', 'Vitória', '849', 'Lote 04');
INSERT INTO PedidoOnline (NumeroPedido, Cep, Estado, Cidade, Rua, Numero, Compremento) VALUES (2, '34075-361', 'Pernambuco', 'Santos', 'Théo', '77326', 'Casa 5');
INSERT INTO PedidoOnline (NumeroPedido, Cep, Estado, Cidade, Rua, Numero, Compremento) VALUES (3, '03705-247', 'Bahia', 'Várzea Grande', 'Lavínia Travessa', '051', 'Quadra 29');
INSERT INTO PedidoOnline (NumeroPedido, Cep, Estado, Cidade, Rua, Numero, Compremento) VALUES (5, '19467-112', 'Minas Gerais', 'Cuiabá', 'Isis', '5714', 'Apto. 633');
INSERT INTO PedidoOnline (NumeroPedido, Cep, Estado, Cidade, Rua, Numero, Compremento) VALUES (7, '03658-508', 'Alagoas', 'Carapicuíba', 'Albuquerque Travessa', '979', 'Casa 5');

-- Povoando tuplas PedidoTemExemplar

INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (1, 37.9, 1, 5);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (2, 37.9, 1, 6);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (3, 61.95, 2, 37);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (4, 58.89, 2, 33);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (5, 57.9, 2, 28);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (6, 37.9, 3, 20);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (7, 47.99, 4, 17);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (8, 64.99, 5, 43);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (9, 37.85, 6, 46);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (10, 57.87, 7, 52);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (11, 30.99, 8, 23);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (12, 45.53, 9, 40);
INSERT INTO PedidoTemExemplar (Id, Preco, NumeroPedido, CodigoExemplar) VALUES (13, 54.95, 10, 11);

-- Criando Indices

CREATE INDEX index_cliente ON Cliente (Codigo);

CREATE INDEX index_clienteFisico ON ClienteFisico (CodigoCliente);

CREATE INDEX index_clienteJuridico ON ClienteJuridico (CodigoCliente);

CREATE INDEX index_pedido ON Pedido (Numero);

CREATE INDEX index_pedidoPresencial ON PedidoPresencial (NumeroPedido);

CREATE INDEX index_pedidoOnline ON PedidoOnline (NumeroPedido);

CREATE INDEX index_funcionario ON Funcionario (Codigo);

CREATE INDEX index_exemplar ON Exemplar (Codigo);

CREATE INDEX index_pedidoTemExemplar ON PedidoTemExemplar (Id);

CREATE INDEX index_livro ON Livro (Codigo);

CREATE INDEX index_livroAutor ON LivroAutor (CodigoLivro);

CREATE INDEX index_livroCategoria ON LivroCategoria (CodigoLivro);

CREATE INDEX index_editora ON Editora (Cnpj);

CREATE INDEX index_telefoneEditora ON TelefoneEditora (CnpjEditora);

CREATE INDEX index_emailEditora ON EmailEditora (CnpjEditora);


-- Visões

/*
* Visão 01: recuperar todas informações a respeito dos livros além
* de quantos exemplares disponíveis para venda existem de cada.
**/

CREATE VIEW Estoque AS (
	SELECT liv.Codigo, liv.Titulo, liv.Preco, liv.Ano_de_lancamento, liv.CnpjEditora, Count(*) AS QuantDisponiveis
	FROM Exemplar exe JOIN Livro liv ON exe.CodigoLivro = liv.Codigo
	WHERE exe.Status = 'Disponivel'
	GROUP BY liv.Codigo, liv.Titulo, liv.Preco, liv.Ano_de_lancamento, liv.CnpjEditora
	ORDER BY Codigo
);

/*
* Visão 02: recuperar todas informações a 
* respeito dos pedidos onlines
**/

CREATE VIEW PedidoOnlineDetalhado AS (
	SELECT
		ped.Numero AS NumeroPedido, ped.Status, ped.Valor, ped.Data, ped.Forma_de_pagamento, ped.CodigoCliente,
		po.Cep, po.Estado, po.Cidade, po.Rua, po.Numero AS NumeroResidencia, po.Compremento
	FROM Pedido ped JOIN PedidoOnline po ON ped.Numero = po.NumeroPedido
);

/**
* Visão 03: recuperar o codigo, nome, e quantidade
* de pedidos realizada por cada funcionario
**/

CREATE VIEW PedidosPorFuncionarios AS (
	SELECT fun.Codigo, fun.Nome, Count(*) AS QuantPedidos
	FROM pedidoPresencial pp JOIN Funcionario fun ON pp.CodigoFuncionario = fun.Codigo
	GROUP BY fun.Codigo, fun.Nome
	ORDER BY QuantPedidos DESC, Codigo ASC
);


-- Consultas

-- 2 Consultas envolvendo Junções

/**
* Deve retornar o titulo dos livros e o nome do seu autor
**/

SELECT livAut.Autor, liv.Titulo as Livro
FROM LivroAutor livAut
INNER JOIN Livro liv ON livAut.CodigoLivro = liv.Codigo;

/**
* Deve retornar o titulo e a quantidade de exemplares de cada livro
**/

SELECT liv.Titulo, Count(*) AS QuantExemplar
FROM Livro liv 
INNER JOIN Exemplar exp ON liv.Codigo = exp.CodigoLivro
GROUP BY liv.Titulo
ORDER BY QuantExemplar DESC;

-- 2 Consultas envolvendo comparação com valores nulos

/**
* Deve retornar o nome e o unico telefone de cada
* cliente que possuir apenas um telefone
**/

SELECT Nome, Telefone_01
FROM Cliente
WHERE Telefone_02 is null;

/**
* Deve retornar o nome e o unico email de cada
* cliente que possuir apenas um email
**/

SELECT Nome, Email_01
FROM Cliente
WHERE Email_02 is null;

-- 2 Consultas usando buscas por substrings

/**
* Consulte o nome de todos os clientes que 
* começam o nome com a letra ‘C’
**/

SELECT Nome
FROM Cliente
WHERE Nome LIKE 'C%';

/**
* Consulte o nome de todos os livros que 
* começam o nome com a letra ‘A’
**/

SELECT Titulo
FROM Livro
WHERE Titulo LIKE 'A%';

-- 2 Consultas usando envolvendo ordenação

/**
* Orderne todos os titulo dos livros na livraria por ondem crescente
**/

SELECT Titulo
FROM Livro
ORDER BY Titulo;

/**
* Orderne o nome de todas as livraria por ondem crescente
**/

SELECT Nome
FROM Editora
ORDER BY Nome DESC;

-- 2 Consultas aninhadas

/**
* Consulte os dados comuns de clientes de todos os clientes Juridicos
**/

SELECT *
FROM Cliente
WHERE Codigo in (
	SELECT CodigoCliente
	FROM ClienteJuridico
);

/**
* Consulte os dados comuns dos Pedidos de todos os Pedidos Onlines
**/

SELECT *
FROM Pedido
WHERE Numero IN (
    SELECT NumeroPedido
    FROM PedidoOnline
);

-- 2 Consultas aninhadas correlacionadas

/**
* Consulte os dados de todos funcionarios que não 
* possuem nenhuma venda de um pedido pressencial
**/

SELECT *
FROM Funcionario fun
WHERE NOT EXISTS (
	SELECT *
	FROM PedidoPresencial pedPres
	WHERE fun.Codigo = pedPres.CodigoFuncionario
);

/**
* Consulte os dados de todos Clientes Juridicos
**/

SELECT *
FROM Cliente cli
WHERE EXISTS (
	SELECT *
	FROM ClienteJuridico cliJur
	WHERE cli.Codigo = cliJur.CodigoCliente
);

-- 2 Consultas usando operação de conjunto

/**
* Selecione todo os dados sobre os livros 
* que foram lançados em 2019 e 2021
**/

(
	SELECT *
	FROM Livro
	WHERE Ano_de_lancamento = '2021'
UNION
	SELECT *
	FROM Livro
	WHERE Ano_de_lancamento = '2019'
);


/**
* Selecione todo os titulos e categorias dos livros 
* na categoria de ‘Filosofia’ e ‘Romance’
**/

(
	SELECT Titulo, Preco, Ano_de_lancamento
	FROM LivroCategoria livCat
	INNER JOIN Livro liv ON liv.Codigo = livCat.CodigoLivro
	WHERE livCat.Categoria = 'Filosofia'
UNION
	SELECT Titulo, Preco, Ano_de_lancamento
	FROM LivroCategoria livCat
	INNER JOIN Livro liv ON liv.Codigo = livCat.CodigoLivro
	WHERE livCat.Categoria = 'Romance'
);


-- 2 Consultas usando funções agregadas

/**
* Selecione o nome do autor a quantidade de 
* livros escritos por cada autor, ordenado pela quantidade
**/

SELECT Autor, Count(*) as QuantLivros
FROM LivroAutor
GROUP BY Autor
ORDER BY Count(*) desc;

/**
* Selecione o título e o preço do livro mais caro
**/

SELECT titulo, Preco
FROM Livro
WHERE Preco in (
	SELECT Max(Preco)
	FROM Livro
);


-- 2 Consultas usando agrupamentos, dentre as quais pelo menos uma deve usar filtragem de grupo

/**
* Consulte o nome de todas as editoras que 
* possuem mais de um e-mail de contato
**/

SELECT edt.Nome
FROM Editora edt
INNER JOIN EmailEditora emEdt ON edt.Cnpj = emEdt.CnpjEditora
GROUP BY edt.Cnpj
HAVING count(emEdt.Email) > 1;

/**
* Deve retornar o Ano de lançamento e a quantidade 
* de livros registrados lançados nesse ano
**/

SELECT Ano_de_lancamento,
	Count(Titulo) AS QuantLivros
FROM Livro
GROUP BY Ano_de_lancamento
ORDER BY QuantLivros DESC;

-- Procedimentos Armazenados

/**
* Procedimento Armazenado 01: Função criada para retornar a 
* quantidade de pedidos registrados por um funcionario
**/

CREATE OR REPLACE FUNCTION NumeroDePedidosPorFuncionario(INTEGER) 
RETURNS INTEGER AS 
$$
	DECLARE
		codFuncionario ALIAS FOR $1;
		quantPedidos INTEGER;
	BEGIN
		SELECT INTO quantPedidos Count(*) 
		FROM PedidoPresencial pp 
		WHERE pp.CodigoFuncionario = codFuncionario;
		RETURN quantPedidos;
	END
$$ LANGUAGE PLPGSQL;

/**
* Procedimento Armazenado 02: Recuperar quantas vezes
* o livro determinado pelo código passado foi vendido.
**/

CREATE OR REPLACE FUNCTION NumeroDeVendas(INT)
RETURNS INT AS
$$
	DECLARE
		codLivro ALIAS FOR $1;
		resultado INT;
	BEGIN
		SELECT INTO resultado COUNT(*)
		FROM PedidoTemExemplar pte, Exemplar exe, Livro liv
		WHERE
			(pte.CodigoExemplar = E.Codigo AND exe.CodigoLivro = liv.Codigo) AND
			liv.Codigo = codLivro;
		RETURN resultado;
	END
$$ LANGUAGE PLPGSQL;

/**
* Procedimento Armazenado 03: Recuperar a quantidade 
* de livros de uma editora, determinada pelo seu codigo.
**/

CREATE OR REPLACE FUNCTION NumeroDeLivrodeEditora(CHARACTER(14))
RETURNS INTEGER AS
$$
    DECLARE
        CnpjEntrada ALIAS FOR $1;
        Resultado INTEGER;
    BEGIN
		SELECT INTO Resultado COUNT(*) AS QuantLivros
		FROM Editora edt
		INNER JOIN livro liv ON edt.Cnpj = liv.CnpjEditora
		WHERE edt.Cnpj = CnpjEntrada
		GROUP BY edt.Cnpj;
		RETURN resultado;
    END
$$ LANGUAGE PLPGSQL;


-- Gatilhos

/**
* Gatilho 01: Atualizar status de exemplares
* adicionados a vendas para indisponível.
**/

CREATE OR REPLACE FUNCTION AtualizarStatusExemplar()
RETURNS TRIGGER AS
$$
	BEGIN
		UPDATE Exemplar
		SET Status = 'Indisponivel'
		WHERE Codigo = NEW.CodigoExemplar;
		RETURN NULL;
	END
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER AtualizarStatusExemplar
AFTER INSERT ON PedidoTemExemplar
FOR EACH ROW
EXECUTE PROCEDURE AtualizarStatusExemplar();

/*
* Gatilho 02: Atualizar status do pedido
* ao adicionar novo pedidoPresencial.
**/

CREATE OR REPLACE FUNCTION AtualizarStatusPedido()
RETURNS TRIGGER AS 
$$
	BEGIN
		UPDATE Pedido
		SET Status = 'Entregue'
		WHERE NEW.NumeroPedido = Numero;
		RETURN NULL;
	END
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER AtualizaStatusPedido 
AFTER INSERT ON PedidoPresencial
FOR EACH ROW
EXECUTE PROCEDURE AtualizarStatusPedido();

/*
* Gatilho 03: Atualizar a forma de pagamento do
* pedido quando adicionado novo pedidoOnline.
**/

CREATE OR REPLACE FUNCTION AtualizarFormaDePagamentoPedido()
RETURNS TRIGGER AS
$$
	BEGIN
		UPDATE Pedido
		SET Forma_de_pagamento = 'Cartão'
		WHERE NEW.NumeroPedido = Numero;
		RETURN NULL;
	END
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER AtualizaFormaDePagamentoPedido 
AFTER INSERT ON PedidoOnline
FOR EACH ROW
EXECUTE PROCEDURE AtualizarFormaDePagamentoPedido();