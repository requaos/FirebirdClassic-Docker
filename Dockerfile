FROM centos:7

ADD ./FirebirdCS-2.5.5.evo-7211.amd64.tar.gz /tmp/

COPY ./scripts/install.sh /tmp/FirebirdCS-2.5.5.evo/
COPY ./scripts/launch.sh /tmp/
COPY ./scripts/postinstall.sh /tmp/FirebirdCS-2.5.5.evo/scripts/
COPY ./scripts/changeMultiConnectMode.sh /tmp/FirebirdCS-2.5.5.evo/scripts/

RUN chmod +x /tmp/launch.sh && chmod +x /tmp/FirebirdCS-2.5.5.evo/install.sh && chmod +x /tmp/FirebirdCS-2.5.5.evo/scripts/postinstall.sh && yum install -y compat-libstdc++-33 wget xinetd bzip2 zip unzip patch ntp ntpdate lsof net-tools psmisc
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

EXPOSE 3050/tcp

ENTRYPOINT [ "/tmp/launch.sh" ]
CMD [ "xinetd", "-dontfork" ]