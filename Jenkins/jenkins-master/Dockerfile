FROM jenkins:latest
MAINTAINER Ali Bhagat

USER root

ENV ANT_VERSION 1.9.4
ENV SONAR_VERSION 2.4
ENV MAVEN_VERSION 3.3.9

ENV HTTP_PROXY http://proxy.server:port/
ENV HTTPS_PROXY https://proxy.server:port/
ENV http_proxy http://proxy.server:port/
ENV https_proxy https://proxy.server:port/
ENV JAVA_OPTS="-Xmx8192m -Duser.timezone=America/Toronto -Dhttp.proxyHost=http://proxy.server -Dhttp.proxyPort=8000 -Dhttps.proxyHost=https://proxy.server -Dhttps.proxyPort=443"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"

RUN mkdir /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins

RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

###############
#Install Maven
###############
RUN cd && \
    wget http://mirrors.gigenet.com/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -zxvf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} /opt/maven && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz

COPY maven/settings.xml /root/.m2/
COPY maven/sqljdbc42.jar /opt/maven/

ENV MAVEN_HOME /opt/maven/
ENV PATH ${PATH}:/opt/maven/bin

RUN mvn install:install-file \
        -DgroupId=com.microsoft.sqlserver \
        -DartifactId=sqljdbc4 \
        -Dversion=4.2 \
        -Dpackaging=jar \
        -DgeneratePom=true \
        -Dfile=/opt/maven/sqljdbc42.jar

##############################################
#Install Fortify - Source Code Analyzer (SCA)
##############################################
COPY fortify/HPE_Security_Fortify_SCA_and_Apps_16.10_Linux.tar.gz /opt/fortify/
COPY fortify/fortify_license/fortify.license /opt/fortify/
COPY fortify/HP_Fortify_SCA_and_Apps_16.10_linux_x64.run.options /opt/fortify/

RUN tar -zxvf /opt/fortify/HPE_Security_Fortify_SCA_and_Apps_16.10_Linux.tar.gz -C /opt/fortify/ && \
    rm /opt/fortify/HPE_Security_Fortify_SCA_and_Apps_16.10_Linux.tar.gz && \
    ./opt/fortify/HP_Fortify_SCA_and_Apps_16.10_linux_x64.run --mode unattended && \
    tar -zxvf /opt/fortify/plugins/maven/maven-plugin-src.tar.gz && \
    mvn clean install && \
    ./opt/fortify/bin/fortifyupdate

ENV FORTIFY_HOME /opt/fortify
ENV PATH ${PATH}:/opt/fortify/bin

#############
#Install Ant
#############
RUN cd && \
    wget -q http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz

#Setup Ant on Jenkins Container
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

##########################
#Install Sonarqube Runner
##########################
RUN cd && \
    wget -q  http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/${SONAR_VERSION}/sonar-runner-dist-${SONAR_VERSION}.zip && \
    unzip sonar-runner-dist-${SONAR_VERSION}.zip && \
    mv sonar-runner-${SONAR_VERSION} /opt/sonar-runner && \
    rm sonar-runner-dist-${SONAR_VERSION}.zip

#Setup Sonar Runner on Jenkins Container
ENV SONAR_RUNNER_HOME /opt/sonar-runner
ENV PATH ${PATH}:/opt/sonar-runner/bin 

#############
#Install node
#############
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs

COPY plugins.txt /usr/share/jenkins/plugins.txt

RUN ["/usr/local/bin/plugins.sh","/usr/share/jenkins/plugins.txt"]

#USER jenkins
