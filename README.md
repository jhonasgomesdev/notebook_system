gestão-de-notebooks


## 📖 Sobre o Projeto
O Gestão de Notebooks é uma aplicação web completa desenvolvida em Ruby on Rails, criada para solucionar o desafio de gerenciamento de empréstimos de equipamentos em um ambiente corporativo.

O sistema oferece uma interface amigável e robusta para controlar todo o ciclo de vida de um notebook: desde o seu cadastro, passando por múltiplos empréstimos e devoluções, até a sua baixa definitiva. Este projeto foi construído como parte de um desafio técnico para a vaga de Desenvolvedor Full Stack Jr., com foco em boas práticas de desenvolvimento, testes automatizados e design de software.

## ✨ Funcionalidades
✅ **CRUD Completo:** Gestão total de Notebooks e Colaboradores.

🔄 **Ciclo de Vida do Equipamento:** Lógica de negócio para Empréstimo, Devolução e Baixa de notebooks.

🔐 **Controle de Estado:** Sistema de estados (disponível, emprestado, indisponível) que controla as ações possíveis para cada notebook.

📊 **Histórico Completo:** Cada empréstimo é registrado, criando um log de transações detalhado para cada equipamento e colaborador.

🔍 **Busca e Filtros Avançados:** Ferramenta de busca na listagem principal que permite filtrar por múltiplos critérios, incluindo texto, estado, colaborador, setor e datas.

🧪 **Qualidade Garantida:** Cobertura de testes unitários e de integração superior a 80%, garantindo a estabilidade e a confiabilidade da aplicação.

🎨 **Interface Moderna:** Design limpo e responsivo, construído com o framework CSS Bootstrap 5.

## 🛠️ Tecnologias
As seguintes ferramentas e tecnologias foram utilizadas na construção do projeto:

*Ruby (v3.3.0)*

*Ruby on Rails (v8.0)*

*PostgreSQL*

*Puma (Web Server)*

*Bootstrap (Framework CSS)*

*Minitest (Testes Automatizados)*

*SimpleCov (Relatório de Cobertura de Testes)*

*Faker (Geração de Dados de Teste)*

## 🚀 Começando
Para executar este projeto em seu ambiente local, siga os passos abaixo.

**Pré-requisitos**
Antes de começar, você vai precisar ter instalado em sua máquina:

*Ruby (v3.3.0 ou superior)*

*Bundler (gem install bundler)*

*PostgreSQL (servidor deve estar rodando)*

*Git*

**Instalação e Execução**
Clone o repositório:

Bash

git clone <https://github.com/jhonasgomesdev/notebook_system.git>
Navegue até o diretório do projeto:

Bash

cd notebook_system
Instale as dependências do projeto com o Bundler:

Bash

bundle install
Configure seu banco de dados. Edite o arquivo config/database.yml com seu usuário e senha do PostgreSQL. Exemplo:

YAML

default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres # SEU_USUARIO
  password: "" # SUA_SENHA
Crie, migre e popule o banco de dados com os comandos do Rails:

Bash

# Cria os bancos de dados de desenvolvimento e teste
rails db:create

# Executa as migrações para criar as tabelas
rails db:migrate

# Popula o banco com dados de teste realistas
rails db:seed
Inicie o servidor Rails:

Bash

rails server
No Windows, se encontrar problemas, use ruby bin/rails server.

Abra seu navegador e acesse http://localhost:3000 para ver a aplicação funcionando!

## 🧪 Rodando os Testes
Para executar a suíte de testes completa e verificar a cobertura, utilize o seguinte comando:

Bash

rails test
Após a execução, um relatório de cobertura detalhado estará disponível em coverage/index.html.

---

## 👨‍💻 Autor

Feito com ❤️ por **Jhonas Gomes**.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jhonasgomes/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/jhonasgomesdev)