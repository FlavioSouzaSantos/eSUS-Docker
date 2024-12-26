FROM openjdk:17-jdk-bullseye
#argumentos para build
#Link para download do instalador versão Linux.
ARG URL_DOWNLOAD_ESUS="https://arquivos.esusab.ufsc.br/PEC/1af9b7ee9c3886bd/5.3.21/eSUS-AB-PEC-5.3.21-Linux64.jar"
#Configurações de conexão com o banco de dados. Por padrão assume que esteja na máquina host
ARG APP_DB_URL="jdbc:postgresql://host.docker.internal:5433/esus"
ARG APP_DB_USER="postgres"
ARG APP_DB_PASSWORD="esus"

RUN echo " Argumentos da build ->  ${APP_DB_URL} - ${APP_DB_USER} - ${APP_DB_PASSWORD}"

#Atualiza a sources.list do Debian para poder instalar as fonts do windows.
RUN cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free
deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free
EOF
RUN apt update
RUN apt-get install -y ttf-mscorefonts-installer
#Instala o init e o file porque o instalador do ESUS executa esses comandos.
RUN apt-get install -y init
RUN apt-get install -y file
RUN apt clean

#Define o fuso horário, coloque o fuso horário de sua região.
RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/Etc/GMT+4 /etc/localtime
#Aplique o mesmo fuso horário do localtime, essa variável de ambiente é necessária para o Java pergar corretamente o fuso.
ENV TZ=Etc/GMT+4

#Copia e dá permissão de execução ao script de inicializacão.
COPY startup.sh /opt
RUN chmod +x /opt/startup.sh

WORKDIR /home/downloads
RUN wget -O eSUS-AB-PEC.jar ${URL_DOWNLOAD_ESUS} --no-check-certificate
RUN echo "s" | java -jar eSUS-AB-PEC.jar -console -url=${APP_DB_URL} -username=${APP_DB_USER} -password=${APP_DB_PASSWORD}
#Extrai o migrador do banco de dados para ser executado na inicialização.
RUN jar xf eSUS-AB-PEC.jar
RUN cp container/database/migrador.jar /opt/e-SUS
#Limpa os aquivos baixados e extraídos.
RUN rm -r /home/downloads/*
EXPOSE 8080
ENTRYPOINT ["/opt/startup.sh"]