<h1 align="center"> ☁️ Media Heaven </h1>

## Sobre
Projeto desenvolvido para a disciplina de Tópicos em Engenharia de Software, com objetivo de aprofundar os conhecimentos de criaçāo de aplicaçōes em nuvem da AWS. O **frontend** foi criado utilizando o Framework [Flutter](https://flutter.dev/) e a Linguagem [Dart](https://dart.dev/), enquanto o **backend** utiliza uma API desenvolvida com [Django](https://docs.djangoproject.com/en/5.0/ref/). 

## Funcionalidades (1ª iteraçāo)
Acerca das funcionalidades desenvolvidas:

1. Login da pessoa usuária;
2. Cadastro da pessoa usuária;
3. Logout;
4. Load Session (verificaçāo de sessāo para manter _Dashboard_ disponível). 

https://github.com/user-attachments/assets/654826d9-a9ff-48dc-93fa-ecc962064bc4

## Frontend (Framework Flutter)

Algumas bilbiotecas também foram utilizadas:

> `Flutter Bloc`: Biblioteca utilizada para gerenciar o estado das telas.

> `Get_it`: Biblioteca utilizada para injeçāo de dependências.

> `http`: Biblioteca utilizada para fazer requisição HTTP.


### Como executar no Flutter

Primeiro você deve [instalar flutter](https://docs.flutter.dev/get-started/install). Então, você pode clonar e entrar na pasta do projeto:

```bash
git clone https://github.com/M3L4O/media-haven.git
cd media-haven/entrypoint/frontend
```

Agora, para testar, você deve instalar os pacotes/dependências e usar um dispositivo conectado ao seu computador ou usar um emulador:

```bash
flutter pub get
flutter run
```

## Backend (Django API)

> `login/`: 
recebe: {email: str, password:str},
retorna: {acess_token: str, username: str}

> `sign_up/`:
recebe: {email: str, username:str, password:str},
retorna: {acess_token: str, username: str}

> `load_session/`:
recebe: {token: str},
retorna: {acess_token: str, username: str}

> `logout/`:
recebe: {acess_token:str}
retorna: 200 ou 404

## Pessoas contribuidoras

| [<img loading="lazy" src="https://avatars.githubusercontent.com/u/57508736?v=4" width=115><br><sub> Jhoisnáyra Vitória </sub>](https://github.com/jhoisz) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/83297541?v=4" width=115><br><sub> Joāo Victor Melo </sub>](https://github.com/M3L4O) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/91147230?v=4" width=115><br><sub> Ícaro Gabryel </sub>](https://github.com/icarogabryel) | [<img loading="lazy" src="https://avatars.githubusercontent.com/u/103615867?v=4" width=115><br><sub> Ana Leticia </sub>](https://github.com/Let0210) | [<img loading="lazy" src="https://avatars.githubusercontent.com/u/67970167?v=4" width=115><br><sub> Wesley Vitor </sub>](https://github.com/wesleyvitor11000) |
| :---: | :---: | :---: | :---: | :---: |
