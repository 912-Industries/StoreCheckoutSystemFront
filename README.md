# StoreCheckout - Sistema de Administração

## Descrição

O StoreCheckout é um projeto que visa fornecer um sistema de administração para uma loja virtual, construído com o uso de tecnologias como Java, Spring Boot, MySQL e Flutter. Este sistema capacita os administradores a gerenciar produtos, processar pedidos e supervisionar o funcionamento geral da loja.

## Funcionalidades

- Gestão completa de produtos, incluindo adição, atualização e remoção.
- Processamento eficiente de pedidos dos clientes.
- Monitoramento de vendas e estoque.
- Integração com sistema de pagamento.
- Segurança avançada na autenticação e autorização de administradores.

## Tecnologias Utilizadas

### Backend (Java, Spring Boot, MySQL)

- **Java**: Linguagem de programação robusta e amplamente adotada.
- **Spring Boot**: Framework que simplifica o desenvolvimento de aplicativos Java, oferecendo configurações pré-definidas.
- **MySQL**: Sistema de gerenciamento de banco de dados relacional, adequado para armazenamento e recuperação eficiente de dados.

### Frontend (Flutter)

- **Flutter**: Framework para desenvolvimento de aplicativos móveis multiplataforma, permitindo a criação de interfaces nativas para iOS e Android a partir de um único código-base.

## Estrutura do Projeto

StoreCheckoutSystem/
├── backend/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   ├── com/
│   │   │   │   │   ├── storecheckoutsystem/
│   │   │   │   │   │   ├── config/
│   │   │   │   │   │   ├── controller/
│   │   │   │   │   │   ├── model/
│   │   │   │   │   │   ├── repository/
│   │   │   │   │   │   ├── services/
│   │   │   │   │   │   ├── StoreCheckoutApplication.java
│   │   │   ├── resources/
│   │   │   │   ├── application.properties
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── login.dart
│   │   ├── home/
│   │   │   ├── configuracoes.dart
│   │   │   ├── estoque.dart
│   │   │   ├── home.dart
│   │   │   ├── vendas.dart
├── services/
│   ├── validate_service.dart
├── widgets/
│   ├── bottom_nav_bar.dart
├── main.dart
├── README.md




## Executando o Projeto

### Backend

1. Verifique se possui o Java e o MySQL instalados.
2. Configure as credenciais do banco de dados no arquivo `application.properties` em `backend/src/main/resources`.
3. Importe o dump do banco de dados utilizando o seguinte comando no terminal:
   ```mysql -u <seu_usuario> -p <seu_banco_de_dados> < caminho/do/arquivo.sql```
4. Execute a classe StoreCheckoutsystemApplication.java

### Frontend

1. Instale o Flutter em seu ambiente de desenvolvimento.
2. Acesse o diretório `frontend` pelo terminal.
3. Execute `flutter pub get` para obter as dependências.
4. Inicie o aplicativo com `flutter run`.

Este projeto tem o propósito educativo e pode ser personalizado conforme suas necessidades.

**Observação**: É recomendado ter um conhecimento básico das tecnologias Java, Spring Boot, MySQL e Flutter. Consulte a documentação oficial de cada tecnologia para mais detalhes sobre seu uso.
