FROM ubuntu:latest

MAINTAINER Ali Bhagat

ENV HTTP_PROXY http://proxy.server:8000/
ENV HTTPS_PROXY https://proxy.server:443/
ENV http_proxy http://proxy.server:8000/
ENV https_proxy https://proxy.server:443/

#ENV JAR_NAME

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer && \
    mkdir /home/services

#COPY $JAR_NAME /home/services

#CMD ["java","-jar","home/services/JAR_NAME"]

EXPOSE 8080
