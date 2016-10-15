FROM chrisipa/java
MAINTAINER Ali Bhagat

# set environment variables
ENV SONARQUBE_HOME /opt/sonarqube
ENV SONARQUBE_VERSION 5.6
ENV SONARQUBE_CHECKSUM 9ca7f69cce0bbbe519fc08da7c592d56

ENV HTTP_PROXY http://proxy.server:8000/
ENV HTTPS_PROXY https://proxy.server:443/

ENV http_proxy http://proxy.server:8000/
ENV https_proxy https://proxy.server:443/

# download and extract sonarqube to opt folder
RUN wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONARQUBE_VERSION.zip && \
    unzip sonarqube-$SONARQUBE_VERSION.zip -d /opt && \
    ln -s /opt/sonarqube-$SONARQUBE_VERSION $SONARQUBE_HOME && \
    rm -f sonarqube-$SONARQUBE_VERSION.zip

# remove unused folders
RUN rm -rf $SONARQUBE_HOME/bin

# expose http port
EXPOSE 9000

# specify volumes
VOLUME ["$SONARQUBE_HOME/conf", "$SONARQUBE_HOME/data", "$SONARQUBE_HOME/extensions", "$SONARQUBE_HOME/logs"]

# set SONARQUBE_HOME as work dir
WORKDIR $SONARQUBE_HOME

# copy entry point to docker image root
COPY docker-entrypoint.sh /entrypoint.sh

# specifiy entrypoint
ENTRYPOINT ["/entrypoint.sh"]
