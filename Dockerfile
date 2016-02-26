FROM debian:jessie
MAINTAINER it-operations@boerse-go.de

RUN echo "deb http://repo.zabbix.com/zabbix/3.0/debian jessie main" > /etc/apt/sources.list.d/zabbix.list && \
    apt-get update -y && \
    apt-get install -y curl && \
    curl http://repo.zabbix.com/zabbix-official-repo.key | apt-key add - && \
    apt-get update -y && \
    apt-get install -y zabbix-agent && \
    /bin/mkdir -p /run/zabbix && \
    /bin/chown -R zabbix:zabbix /run/zabbix
ADD etc#zabbix#zabbix_agentd.conf.d/* /etc/zabbix/zabbix_agentd.conf.d/
ADD etc#zabbix#zabbix_agentd.conf.d/* /etc/zabbix/zabbix_agentd.d/

EXPOSE 10050

CMD ["/usr/sbin/zabbix_agentd", "--foreground"]
#CMD ["/bin/bash"]
