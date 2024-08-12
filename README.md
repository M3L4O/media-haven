<h1 align="center"> ☁️ Media Heaven </h1>

## Sobre
Projeto desenvolvido para a disciplina de Tópicos em Engenharia de Software, com objetivo de aprofundar os conhecimentos de criaçāo de aplicaçōes em nuvem da AWS. O **frontend** foi criado utilizando o Framework [Flutter](https://flutter.dev/) e a Linguagem [Dart](https://dart.dev/), enquanto o **backend** utiliza uma API desenvolvida com [Django](https://docs.djangoproject.com/en/5.0/ref/). 

## Funcionalidades
Acerca das funcionalidades desenvolvidas:

1. Login da pessoa usuária;
2. Cadastro da pessoa usuária;
3. Logout;
4. Upload de imagens, vídeos e aúdios;
5. Delete de imagens, vídeos e aúdios;
6. Destalhes de imagens, vídeios e aúdios;
7. Visualizaçāo dos arquivos;
8. Listagem com busca e filtros.

**[🔗 link para vídeos do projeto em execuçāo](https://drive.google.com/drive/folders/13thCFGqY-M-tHVMUQ1vovENslBGf-MDR?usp=sharing)** 

## Frontend (Framework Flutter)

Algumas bilbiotecas também foram utilizadas:

> `Flutter Bloc`: Biblioteca utilizada para gerenciar o estado das telas.

> `Get_it`: Biblioteca utilizada para injeçāo de dependências.

> `http`: Biblioteca utilizada para fazer requisição HTTP.

> `google_fonts`: Biblioteca utilizada para facilitar o uso de fontes do Google no projeto.

> `lottie`: Biblioteca utilizada para exibir animações Lottie.

> `shared_preferences`: Biblioteca utilizada para armazenar dados de forma persistente no dispositivo.

> `file_picker`: Biblioteca utilizada para selecionar arquivos do dispositivo.

> `mime`: Biblioteca utilizada para identificar o tipo MIME de arquivos.

> `http_parser`: Biblioteca utilizada para analisar e manipular URLs e dados de requisições HTTP.

> `video_player`: Biblioteca utilizada para reproduzir vídeos no aplicativo.

> `html`: Biblioteca utilizada para renderizar e manipular HTML.

> `just_audio`: Biblioteca utilizada para reprodução de áudio.

> `cached_network_image`: Biblioteca utilizada para carregar e armazenar em cache imagens da internet.

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

## Backend (Django Restframework API)
Primeiramente é necessário configurar o ambiente para a aplicação, começando pela montagem do S3 nas instâncias.

Utilizando o AMZ Linux:

```bash
sudo yum install git
sudo yum groupinstall "Development Tools"
sudo yum install fuse
sudo yum install automake autoconf gcc-c++ libcurl-devel libxml2-devel
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
./autogen.sh
./configure
make
sudo make install
```

Utilizando Ubuntu pode-se instalar via APT, o gerenciador de pacote do ubuntu:

```bash
sudo apt-get install s3fs -y
```

Ou pode-se instalar a partir do código fonte

```bash
sudo apt-get install automake autotools-dev fuse g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
./autogen.sh
./configure
make
sudo make install
```

Com o S3FS instalado, agora é necessário criar a pasta onde será o ponto de montagem:

```bash
mkdir /home/media
```

Com a pasta pronta, basta apenas criar o arquivo secreto:

```bash
echo "ACCESS_KEY_ID:SECRET_ACCESS_KEY" > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

E, por fim, realmente montar o S3 numa instância EC2:

```bash
sudo s3fs bucket-name /home/media/ -o passwd_file=~/.passwd-s3fs -o url=https://s3.amazonaws.com
```
Para verificar se está realmente montado, pode-se criar arquivos e olhar na interface do S3:

```bash
cd /home/media
touch teste.txt
```
Se aparecer o arquivo na interface, logo o S3 está realmente montado.

Link para a documentação completa da API:
> https://documenter.getpostman.com/view/33062932/2sA3rxpsk4

### Como executar as DRF APIs

É necessário clonar o repositório da aplicação:

```bash
git clone https://github.com/M3L4O/media-haven.git
```
Em seguida, deve-se criar um ambiente virtual e instalar as dependências:

```bash
cd media-haven/src
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
Após isso, é necessário configurar as variáveis de ambiente:

```bash
export RDS_DB_NAME=<db_name>
export RDS_USERNAME=<username>
export RDS_PASSWORD=<password>
export RDS_HOSTNAME=<endpoint RDS>
export RDS_PORT=5432
export MEDIA_ROOT_PATH=<montagem S3>
export PROCESSOR_URL=<ip_processor:port>
export APPLICATION_URL=<ip_application:port>
```

Dessa forma é possível executar as duas APIs:

(1) Servidor de aplicação:

```bash
cd application
python manage.py makemigrations account file
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
```

(2) Servidor de processamento de mídia:

```bash
cd media_processing
python manage.py runserver 0.0.0.0:3000
```


## Pessoas contribuidoras

| [<img loading="lazy" src="https://avatars.githubusercontent.com/u/57508736?v=4" width=115><br><sub> Jhoisnáyra Vitória </sub>](https://github.com/jhoisz) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/83297541?v=4" width=115><br><sub> Joāo Victor Melo </sub>](https://github.com/M3L4O) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/91147230?v=4" width=115><br><sub> Ícaro Gabryel </sub>](https://github.com/icarogabryel) | [<img loading="lazy" src="https://avatars.githubusercontent.com/u/103615867?v=4" width=115><br><sub> Ana Leticia </sub>](https://github.com/Let0210) | [<img loading="lazy" src="https://avatars.githubusercontent.com/u/67970167?v=4" width=115><br><sub> Wesley Vitor </sub>](https://github.com/wesleyvitor11000) |
| :---: | :---: | :---: | :---: | :---: |
