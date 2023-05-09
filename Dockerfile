FROM jrei/systemd-ubuntu

ENV INSTALL_DIR="/build"

RUN set -x && \
    apt-get update -y && \
    apt-get install -y apt-utils wget && \
    mkdir $INSTALL_DIR && \
    cd $INSTALL_DIR && \
    wget http://www.aishub.net/downloads/dispatcher/install_dispatcher && \
    chmod 755 $INSTALL_DIR/install_dispatcher && \
    apt-get install -y bzip2 iproute2 && \
    $INSTALL_DIR/install_dispatcher && \
    apt-get autoremove -y

COPY healthcheck.sh /
COPY fw-console.conf /etc/systemd/journald.conf.d/

# Expose ports
EXPOSE 8080/tcp
EXPOSE 8081/tcp
EXPOSE 10110/udp

# Add healthcheck
HEALTHCHECK --start-period=10s --interval=60s  CMD /healthcheck.sh
