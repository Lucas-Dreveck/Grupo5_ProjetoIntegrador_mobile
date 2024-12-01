# Aplicativo Mobile Ambiente-se

Ambiente-se é um aplicativo móvel projetado para avaliar e classificar empresas com base em critérios de Governança Ambiental, Social e Corporativa (ESG). O objetivo do app é incentivar práticas sustentáveis, fornecendo avaliações detalhadas e insights que ajudam empresas e indivíduos a tomarem decisões informadas.

## 📝 Visão Geral do Projeto

Ambiente-se faz parte da iniciativa Grupo5 Projeto Integrador Mobile. O aplicativo oferece uma plataforma completa para avaliar o desempenho de empresas em áreas-chave de sustentabilidade, tornando os dados ESG acessíveis e acionáveis para os usuários.

### Principais Objetivos

- Promover a conscientização sobre os princípios ESG.
- Permitir que os usuários avaliem empresas de forma eficiente.
- Oferecer insights claros e acionáveis por meio de relatórios interativos.

## 🌟 Funcionalidades

- Avaliação de Empresas: Avalie empresas com base em um framework ESG padronizado.
- Relatórios Interativos: Visualize o desempenho das empresas com gráficos e tabelas dinâmicas.
- Contas de Usuário: Registro e login seguros para uma experiência personalizada.
- Busca e Filtro: Encontre empresas facilmente por nome, setor ou pontuação ESG.
- Insights de Sustentabilidade: Gere e compartilhe relatórios detalhados sobre o desempenho das empresas.

## 🛠️ Tecnologias Utilizadas

### Frontend

- **Flutter:** Framework para desenvolvimento de aplicativos móveis.
- **Dart:** Linguagem de programação para o Flutter.
- **Figma:** Ferramenta de design para UI/UX.

### Backend

- **Spring Boot:** Framework Java para o desenvolvimento de APIs REST.
- **MySQL:** Banco de dados relacional.
- **Swagger:** Documentação interativa da API.
- **Docker:** Conteinerização para portabilidade e testes.
- **JWT:** Autenticação segura por tokens.

## 🚀 Como Rodar

### Passos Iniciais

#### 1. Clone o repositório e acesse a pasta criada:

```bash
git clone https://github.com/Lucas-Dreveck/ProjetoIntegrador-Ambientese.git
cd ProjetoIntegrador-Ambientese
```

#### 2. Configuração do backend:

- Acesse o arquivo env.properties.example em src/main/resources/.
- Duplique e renomeie para env.properties.
- Insira as credenciais conforme orientações no arquivo.
- Verifique o arquivo application.properties para ajustes adicionais.

### Backend - Inicialização

#### 1. Via Docker:

Execute o projeto usando Docker Compose:

```bash
docker compose up --build
```

Ou, se estiver usando Docker Compose standalone:

```bash
docker-compose up --build
```

O backend estará disponível em http://localhost:8080.

#### 2. Manualmente com Spring Boot:

Certifique-se de ter o Maven e o Java 17 instalados:

- Download [Maven](https://maven.apache.org/download.cgi)

- Download [Java 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html)

Execute o comando abaixo na pasta raiz do backend:

```bash
mvn spring-boot:run
```

- API disponível em [Localhost](localhost:8080)
- Documentação interativa via [Swagger](http://localhost:8080/swagger-ui/index.html#/)

### Frontend - Inicialização

#### 1.Acesse o diretório do frontend:

```bash
cd ambiente_se
```

#### 2. Instale as dependências

```bash
flutter pub get
```

#### 3. Execute o aplicativo

```bash
flutter run
```

#### 4. Compilação para Produção:

- Android:

```bash
flutter build apk
```

- iOS:

```bash
flutter build ios
```

## 📦 Changelog

### Versão 1.1.0 - 2024-11-13

#### Adicionado

- Opção de adicionar imagem para empresas.

#### Melhorias

- Resolvido erros de overflow por algumas telas.
- Resolvido problema no download do pdf via tela de ranking.
- Resolvido problema na paginação do ranking.
- Correção na paleta de cores.

### Versão 1.0.0 - 2024-10-28

#### Adicionado
- Sistema de login.
- Tela de ranking funcional.
- Tela de avaliação completa.
- CRUD para cadastro de empresas e funcionários.

## 👥 Equipe de Desenvolvimento

- [Daniel Henrique Hartmann](https://github.com/DanielHHartmann)
- [Eduardo Longen Corrêa](https://github.com/EduLongen)
- [Gabriel Santos da Costa](https://github.com/gabrielscostaa)
- [Lucas Dreveck](https://github.com/Lucas-Dreveck)
- [Mayumi Bogoni](https://github.com/mayumihb)
- [Paola Julie Santos](https://github.com/paolajulie)
