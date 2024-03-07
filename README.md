# Livraria Nova Era - API

## Sobre do que se trata?

Se trata de um backend criado para treinar, a minha intenção aqui foi criar uma API para um antigo projeto para a disciplina de banco de dados 2, ao qual deveria ser criado scripts em sql para a criação, povoação e tudo o que pedia para concretizar a disciplina, para acessar o projeto conceitual pode visualizar nessa imagem [png](Conceitual.jpeg) e para acessar o restante da construção do trabalho, pode ser acessado na pasta [Trabalho-BD](Trabalho-BD). Na época o projeto deveria ser feito em grupo, então fiz com dois amigos, o [Iago](https://github.com/IagoGOOl) e [Daniel](https://github.com/nadjiel).

# Mudanças

Como esse era apenas um projeto para treinar, decidir ousar um pouco mais e realizei algumas mudanças na estrutura padrão de criação APIs para Node.js, apenas fiz um gerador de controller e um gerador de rotas, ao qual são funções para criar essas routas e controllers apenas os instanciando. Além de ter juntado todos os controllers em um único arquivo antes de importar.

Realizei outras mudanças também, mas essas foram em relação ao projeto da disciplina de BD2, a primeira que posso citar é a mudança de nomes de tabelas e atributos para inglês, já que o padrão seguido na disciplina foi manter o português para tudo, como pode ser visto nesse [sql](Trabalho-BD/Projeto de Banco de Dados.sql), a segunda foi utilizar o prisma para a criação das tabelas, por mais que já tivesse um sql pronto, eu queria treinar mais o uso dessa tecnologia, por isso fiz isso.

# Como Rodar?

Primeiramente se deve configurar o .env, vc pode fazer isso apenas tirando o arquivo .env.example como modelo, lá tem todos as variáveis necessárias para rodar. Depois disso se for da sua preferente pode rodar o docker para a criação do banco de dados, utilize apenas:

```
docker-compose up -d
```

Para instalar as dependências para rodar a aplicação utilize:

```
npm i
```

E por fim pode rodar a aplicação com:

```
npm run dev
```

Se quiser rodar os testes, rode o:

```
npm run test
```

## Repositórios

* GitHub de Pedro (Meu): https://github.com/Pedro35803
* GitHub de Iago: https://github.com/IagoGOOl
* GitHub de Daniel: https://github.com/nadjiel
