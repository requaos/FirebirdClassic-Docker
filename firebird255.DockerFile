FROM centos:7

ADD ./FirebirdCS-2.5.5.evo-7211.amd64.tar.gz /tmp/

RUN yum install -y compat-libstdc++-33 wget xinetd bzip2 zip unzip patch ntp ntpdate lsof net-tools psmisc

EXPOSE 3050/tcp

CMD ["xinetd"]