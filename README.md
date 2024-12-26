# eSUS-Docker
Implantando o e-SUS PEC em container Docker

Gerando as imagens
--
Primeiro vamos criar a imagem do banco de dados que vai ser baseada no PostgreSQL versão 9.6.13-apine, para isso faça o build da imagem usando o Dockerfile que está na pasta database, entre na pasta e utilize o comando ```sudo docker build -t esus_database:1.0 .```.<br/>
Agora vamos criar a imagem do webserver, primeiro copie o link de download da versão do e-SUS PEC direto do site https://sisaps.saude.gov.br/esus/ nesse exemplo utilizerei o link da versão 5.3.21 https://arquivos.esusab.ufsc.br/PEC/1af9b7ee9c3886bd/5.3.21/eSUS-AB-PEC-5.3.21-Linux64.jar.
Vamos agora fazer o build da imagem entrando na pasta webserver, devemos passar os parâmetros necessários  (```URL_DOWNLOAD_ESUS```, ```APP_DB_URL```, ```APP_DB_USER``` e ```APP_DB_PASSWORD```) para o comando de build.<br/>Exemplo : ```sudo docker build --build-arg=URL_DOWNLOAD_ESUS=https://arquivos.esusab.ufsc.br/PEC/1af9b7ee9c3886bd/5.3.21/eSUS-AB-PEC-5.3.21-Linux64.jar --build-arg=APP_DB_URL=jdbc:postgresql://127.0.0.1:5433/esus --build-arg=APP_DB_USER=postgres --build-arg=APP_DB_PASSWORD=esus -t esus_webserver:1.0 .```<br/>

Criando as imagens e executando os containers com Docker compose
--
No diretório raiz do projeto execute o comando ``sudo sh build-service.sh`` esse shell script vai criar as imagens e os containers de forma automática utilizando internamente o arquivo ``docker-compose.yml``.<br/>
Esse script shell é necessário porque ao fazer o build da imagem do webserver é necessário ter um banco de dados em execução, primeiro o script cria a imagem e o container do banco de dados e aguarda eles estarem disponíveis e em seguinda cria a imagem e o container do webserver.

Observação
--
Os nomes das imagens, containers e rede são de sua escolha assim como a bindagem da porta do webserver.
