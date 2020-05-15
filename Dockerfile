## hibiscus.server is running under java-8
FROM ubuntu:groovy
WORKDIR /srv/

## for future use
ENV MYSLQ_HOST=${DB_HOST:-"localhost"}
ENV MYSLQ_USER=${DB_USER:-"hibiscus"}
ENV MYSLQ_PWD=${DB_PWD:-"hibiscus"}
ENV MYSLQ_DB=${DB_NAME:-"hibiscus"}
ENV MYSQL_PORT=${DB_PORT:-"3306"}
ENV MYSQL_ENCODING=${DB_ENCODING:-"UTF-8"}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y git openjdk-8-jdk-headless ant nano && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN git clone https://github.com/willuhn/hibiscus.git && \
	git clone https://github.com/willuhn/hibiscus.server.git
WORKDIR /srv/hibiscus.server/
RUN ant -f build/build.xml
## TODO: fix
##				error: package org.apache.commons.lang does not exist 
##				[javac] import org.apache.commons.lang.StringUtils;


#RUN ./jameicaserver.sh

## to prevent container from closing; no need if server is running.
CMD tail -f /dev/null
