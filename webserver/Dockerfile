FROM centos/systemd
MAINTAINER "Flávio de Souza Santos" <desouza.flavio@gmail.com>
RUN yum -y install file \
	&& yum -y install wget \
	&& yum clean all \
	&& wget https://download.java.net/java/GA/jdk18.0.1.1/65ae32619e2f40f3a9af3af1851d6e19/2/GPL/openjdk-18.0.1.1_linux-x64_bin.tar.gz \
	&& mkdir /usr/lib/jvm/ \
	&& tar zxvf openjdk-18.0.1.1_linux-x64_bin.tar.gz -C /usr/lib/jvm/ \
	&& update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-18.0.1.1/bin/java 1065 \
	&& rm openjdk-18.0.1.1_linux-x64_bin.tar.gz \
	&& mkdir /home/downloads/
	
EXPOSE 8080
VOLUME /opt/e-SUS/
ENV APP_DB_URL=jdbc::postgresql://localhost:5433/esus
ENV APP_DB_USER=posgres
ENV APP_DB_PASSWORD=esus
CMD ["/usr/sbin/init"]
