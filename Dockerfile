FROM centos:7

ENV GOSU_VERSION="1.7" 
ENV GOSU_DOWNLOAD_ROOT="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION" 
ENV GOSU_DOWNLOAD_KEY="0x036A9C25BF357DD4"

ADD ./FirebirdCS-2.5.5.evo-7211.amd64.tar.gz /tmp/

COPY ./scripts/install.sh /tmp/FirebirdCS-2.5.5.evo/
COPY ./scripts/launch.sh /tmp/
COPY ./scripts/postinstall.sh /tmp/FirebirdCS-2.5.5.evo/scripts/
COPY ./scripts/changeMultiConnectMode.sh /tmp/FirebirdCS-2.5.5.evo/scripts/

RUN chmod +x /tmp/launch.sh && chmod +x /tmp/FirebirdCS-2.5.5.evo/install.sh && chmod +x /tmp/FirebirdCS-2.5.5.evo/scripts/postinstall.sh && yum install -y compat-libstdc++-33 wget xinetd bzip2 zip unzip patch ntp ntpdate lsof net-tools psmisc
RUN set -x \
    && gpg-agent --daemon \
    && gpg --keyserver pgp.mit.edu --recv-keys $GOSU_DOWNLOAD_KEY \
    && echo "trusted-key $GOSU_DOWNLOAD_KEY" >> /root/.gnupg/gpg.conf \
    && curl -o /usr/local/bin/gosu -SL "$GOSU_DOWNLOAD_ROOT/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "$GOSU_DOWNLOAD_ROOT/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && rm -rf /root/.gnupg

EXPOSE 3050/tcp

ENTRYPOINT [ "/tmp/launch.sh" ]
CMD [ "xinetd", "-dontfork" ]