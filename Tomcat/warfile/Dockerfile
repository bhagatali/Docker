FROM ubuntu:14.04
MAINTAINER Ali Bhagat

ENV REFRESHED_AT 2016-06-15

ENV HTTP_PROXY http://proxy.server:8000/
ENV HTTPS_PROXY https://proxy.server:443/

ENV http_proxy http://proxy.server:8000/
ENV https_proxy https://proxy.server:443/

RUN apt-get -yqq update
RUN apt-get -yqq install wget

VOLUME [ "/var/lib/tomcat7/webapps/" ]
WORKDIR /var/lib/tomcat7/webapps/

ENTRYPOINT [ "wget" ]
CMD [ "-?" ]

