# Marvel Characters App

Este projeto foi desenvolvido como parte de um desafio técnico.  
O objetivo é criar um aplicativo mobile em Flutter que consuma a API da Marvel, liste personagens e exiba detalhes completos seguindo a interface proposta no Figma.

---

## 🚀 Sobre o projeto

O app segue a arquitetura **Clean Architecture**, separando responsabilidades e permitindo fácil manutenção e testes.

Ao utilizar a aplicação, o usuário pode:

- Buscar a lista de personagens  
- Visualizar detalhes de um personagem  
- Receber feedback de erros em chamadas da API

---

## 📦 Tecnologias utilizadas

- **Flutter 3.32.2**
- **Clean Architecture**
- **Gerenciamento de estado:** Bloc 
- **HTTP Client:** Dio 
- **Testes unitários:** Mocktail

As escolhas foram feitas para manter o código organizado, testável e alinhado com boas práticas do ecossistema Flutter.

---

## 📁 Como rodar o projeto

1. Clone o repositório:
   ```sh
   git clone https://github.com/jonathanvmelo/flutter_marvel_characters.git

2. Instale as dependências:
    flutter pub get

3. Gere sua própria API Key no site da Marvel:
    [key](https://developer.marvel.com/?utm_source=chatgpt.com)

4. Configure sua chave no projeto    
    No arquivo .env, coloque a chave obtida no passo anterior

5. Rode o app:
    flutter run    