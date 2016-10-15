FROM rhel:latest

MAINTAINER Ali Bhagat

ENV HTTP_PROXY http://proxy.server:8000/
ENV HTTPS_PROXY https://proxy.server:443/

ENV http_proxy http://proxy.server:8000/
ENV https_proxy https://proxy.server:443/

# set environment for JBOSS home
ENV EAP_HOME /opt/jboss/jboss-eap-7.0

RUN curl -b oraclelicense=accept-securebackup-cookie -O -L \
          http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.rpm && \
          rpm -ivh jre-8u60-linux-x64.rpm && \
          rm -rf jre-8u60-linux-x64.rpm

ENV JAVA_HOME /usr/java/jre1.8.0_60

# enabling sudo group
# enabling sudo over ssh
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
sed -i 's/.*requiretty$/Defaults !requiretty/' /etc/sudoers

# add a user for the application, with sudo permissions
RUN useradd -m jboss ; echo jboss: | chpasswd ; usermod -a -G wheel jboss

# install JBoss EAP 6.4.0
ADD ./jboss-eap-6.4/ ${EAP_HOME} 

# Add default admin user
RUN ${EAP_HOME}/bin/add-user.sh admin admin123! --silent

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> $EAP_HOME/bin/standalone.conf

# Add volume if you want to externalize logs
VOLUME [$EAP_HOME/standalone/logs,$EAP_HOME/bin]

# set permission folder
RUN chown -R jboss:jboss /opt/jboss

#EXPOSE 8080 9990 9999 
EXPOSE 8080 9990

#CMD ${EAP_HOME}/bin/standalone.sh -c standalone-full.xml

# start JBoss
ENTRYPOINT $EAP_HOME/bin/standalone.sh -c standalone-full.xml

# deploy app
#COPY Service.war "$EAP_HOME/standalone/deployments/"

USER jboss
CMD /bin/bash
