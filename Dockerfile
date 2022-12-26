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
ARG ASTERISK_LINK="http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz"
ARG ASTERISK_VERSION="asterisk-18-current"
ARG ASTERISK_VER="asterisk-18.15.1"
ARG ITUT="011"
ARG FREEPBX_LINK="http://mirror.freepbx.org/modules/packages/freepbx/7.4/freepbx-16.0-latest.tgz"
ARG FREEPBX_VERSION="freepbx-16.0-latest"
ARG NODEJS_LINK="https://deb.nodesource.com/setup_14.x"
ARG LIBSSL_URL="https://wiki.freepbx.org/download/attachments/202375584/libssl1.0.2_1.0.2u-1_deb9u4_amd64.deb"
ARG ODBC_LINK="https://wiki.freepbx.org/download/attachments/122487323/mariadb-connector-odbc_3.0.7-1_amd64.deb"
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
# ENV FOO="BAR"

# Switch to non-root user
USER asterisk

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
