FROM debian:jessie
MAINTAINER Ali Bhagat

RUN useradd -d "/var/jenkins_home" -m -u 1000 -s /bin/bash jenkins
RUN useradd -d "/var/sonar_home" -m -u 1001 -s /bin/bash sonarqube

RUN mkdir -p /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins

VOLUME ["/var/log/jenkins","/var/jenkins_home"]

RUN mkdir -p /opt/sonarqube/conf
RUN chown -R sonarqube:sonarqube /opt/sonarqube/conf
RUN mkdir -p /opt/sonarqube/data
RUN chown -R sonarqube:sonarqube /opt/sonarqube/data
RUN mkdir -p /opt/sonarqube/extensions
RUN chown -R sonarqube:sonarqube /opt/sonarqube/extensions
RUN mkdir -p /opt/sonarqube/logs
RUN chown -R sonarqube:sonarqube /opt/sonarqube/logs

VOLUME ["/opt/sonarqube/conf","/opt/sonarqube/data","/opt/sonarqube/extensions","/opt/sonarqube/logs"]

RUN mkdir -p /var/lib/mysql
RUN chown -R sonarqube:sonarqube /var/lib/mysql

VOLUME ["/var/lib/mysql"]

CMD ["echo","Data container"]
