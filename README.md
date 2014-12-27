[Website](http://burocracia.madeincoimbra.org)

## Sobre ##

Esta aplicação pretende disponibilizar as actas da Câmara Municipal de Coimbra num formato aberto e fácil de pesquisar. As actas são disponibilizadas em PDF, no website da Câmara. Esta aplicação importa, converte para HTML, indexa e disponibiliza essas mesmas actas.

Este é um projecto desenvolvido no [Improve Coimbra](http://improvecoimbra.org/), um evento mensal com o objectivo de encontrar e implementar soluções para melhorar Coimbra.

## Desenvolvimento ##

Informações importantes sobre esta aplicação/repositório.

### Tecnologias ###

* Ruby on Rails
* MongoDB
* SASS (CSS)
* jQuery (Javascript)
* PDFMiner (biblioteca em Python para a conversão das actas de PDF para texto sem formato)

### Desenvolvimento ###

Para executar a aplicação em ambiente de desenvolvimento local são necessários os seguintes passos:

* Instalar o [PDFMiner](https://github.com/euske/pdfminer/)
* Instalar o [MongoDB](http://docs.mongodb.org/manual/installation/) >= 2.4, se ainda não estiver instalado
* Fazer clone do repositório e correr o comando `bundle install` para instalar as dependências
* Criar a pasta para a base de dados, correndo `mkdir db` na root do projecto
* Iniciar o servidor de mongodb com o comando `mongod --dbpath db/`
* Correr o comando `rails server` para iniciar o servidor
* Aceder a [http://localhost:3000](http://localhost:3000)

### Tarefas ###

Rake tasks que podem ser executadas/alteradas

* **import_new_documents** - Procurar novas actas no website da CMC e importá-las para a base de dados
* **fetch_dates** - Identificar as datas das actas dentro do seu conteúdo, se não tiver sido possível na importação

### Produção ###

Para a execução desta aplicação em ambiente de produção é necessário definir as seguintes variáveis de ambiente:

* ADMIN_PASSWORD (password de acesso à zona de administração, o username é "admin")
* MONGODB_HOST (servidor de base de dados MongoDB)
* MONGODB_DATABASE (nome da base de dados MongoDB)
* MONGODB_USERNAME (utilizador da base de dados MongoDB)
* MONGODB_PASSWORD (password do utilizador da base de dados MongoDB)

### Dados de acesso ###

Para aceder à zona de administração em ambiente de desenvolvimento, os dados de acesso são:

* **Username:** improve
* **Password:** improve
