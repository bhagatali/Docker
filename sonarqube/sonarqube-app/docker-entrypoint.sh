#!/bin/bash

set -e

# ------------------------------------------------------------------------
# # function for getting the value of a database environment variable
# ------------------------------------------------------------------------
# $1 - Pattern to search for
# ------------------------------------------------------------------------
function get_db_env_var() {
    local PATTERN="$1"
    echo "$(env | grep $PATTERN | head -n 1 | awk -F= '{print $2}')"
}

# set defaults for database
if [ -z $DB_TYPE ] ; then export DB_TYPE="mysql" ; fi
if [ -z $DB_HOST ] ; then export DB_HOST="$(get_db_env_var 'PORT_3306_TCP_ADDR')" ; fi
if [ -z $DB_PORT ] ; then export DB_PORT="$(get_db_env_var 'PORT_3306_TCP_PORT')" ; fi
if [ -z $DB_NAME ] ; then export DB_NAME="$(get_db_env_var 'MYSQL_DATABASE')" ; fi
if [ -z $DB_USER ] ; then export DB_USER="$(get_db_env_var 'MYSQL_USER')" ; fi
if [ -z $DB_PASS ] ; then export DB_PASS="$(get_db_env_var 'MYSQL_PASSWORD')" ; fi

# set db dialect and db driver class name by db type
case "$DB_TYPE" in
	mysql)
		DB_URL="jdbc:mysql://$DB_HOST:$DB_PORT/$DB_NAME?useUnicode=true&characterEncoding=utf8"
	;;
	postgresql)
		DB_URL="jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME"
	;;
	*)
		echo "ERROR: The db type '$DB_TYPE' is not supported"
		exit 1
	;;
esac

# wait for database port to be opened
while ! nc -z $DB_HOST $DB_PORT; do sleep 1; done

# import trusted ssl certs into JRE keystore
import-trusted-ssl-certs.sh

# start sonarqube application
exec java -jar $SONARQUBE_HOME/lib/sonar-application-$SONARQUBE_VERSION.jar \
     -Dsonar.log.console=true \
     -Dsonar.jdbc.username="$DB_USER" \
     -Dsonar.jdbc.password="$DB_PASS" \
     -Dsonar.jdbc.url="$DB_URL" \
     -Dsonar.web.context="$SONARQUBE_CONTEXT_PATH" \
     -Dsonar.web.javaAdditionalOpts="-Djava.security.egd=file:/dev/./urandom $SONARQUBE_JAVA_OPTS" \
     "$@"

exec "$@"
