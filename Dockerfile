ARG S6_ARCH
FROM oznu/s6-node:14.16.0-${S6_ARCH:-amd64}

RUN apk add --no-cache wget iproute2 cron sudo nano

RUN mkdir -p /etc/hetrixtools_dl

# Download agent from hetrixtools repo
RUN wget https://raw.github.com/hetrixtools/agent/master/hetrixtools_install.sh -P /etc/hetrixtools_dl

# Copy file as the install command will delete the original file
RUN cp etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh
RUN chmod --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh
RUN chown --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh

# Copy start.sh script and allow execution
COPY ./src/start.sh ./start.sh
RUN chmod +x ./start.sh

ENTRYPOINT  ["/bin/bash", "./start.sh"]