FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="FreePbx"
ARG ASTERISK_LINK="https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz"
ARG ASTERISK_VERSION="asterisk-18-current"
ARG ASTERISK_VER="asterisk-18.16.0"
ARG ITUT="011"
ARG FREEPBX_LINK="http://mirror.freepbx.org/modules/packages/freepbx/7.4/freepbx-16.0-latest.tgz"
ARG FREEPBX_VERSION="freepbx-16.0-latest"
ARG NODEJS_LINK="https://deb.nodesource.com/setup_10.x"
ARG ODBC_LINK="https://dlm.mariadb.com/2454041/Connectors/odbc/connector-odbc-3.1.17/mariadb-connector-odbc-3.1.17-ubuntu-focal-amd64.tar.gz?_ga=2.184597664.881678977.1672142889-1090965855.1671769701"
ARG ODBC_VERSION="mariadb-connector-odbc-3.1.17-ubuntu-focal-amd64"
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_NAME="asterisk"
ENV DATABASE_USER="asterisk"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="mariadb"
ENV DATABASE_PORT="3306"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV SERVER_ADDRESS="localhost"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"
ENV HTTP_PORT="8080"
ENV HTTPS_PORT="8443"
ENV SSL_CERT="open"
ENV PROTOCOL="https"

# Switch to non-root user
# USER asterisk

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
