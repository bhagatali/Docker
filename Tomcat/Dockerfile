FROM ubuntu:14.04
MAINTAINER Ali Bhagat

ENV REFRESHED_AT 2016-06-15


ENV HTTP_PROXY http://proxy.server:8000/
ENV HTTPS_PROXY https://proxy.server:443/

ENV http_proxy http://proxy.server:8000/
ENV https_proxy https://proxy.server:443/

RUN apt-get -yqq update
RUN apt-get -yqq install tomcat7 default-jdk

ENV CATALINA_HOME /usr/share/tomcat7
ENV CATALINA_BASE /var/lib/tomcat7
ENV CATALINA_PID /var/run/tomcat7.pid
ENV CATALINA_SH /usr/share/tomcat7/bin/catalina.sh
ENV CATALINA_TMPDIR /tmp/tomcat7-tomcat7-tmp

RUN mkdir -p $CATALINA_TMPDIR

VOLUME [ "/var/lib/tomcat7/webapps/","/var/lib/tomcat7","/usr/share/tomcat7" ]

EXPOSE 8080

ENTRYPOINT [ "/usr/share/tomcat7/bin/catalina.sh", "run" ]

