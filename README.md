# docker-zabbix-agentd
A Debian latest based Docker container running zabbix_agentd in a CoreOS instance. 

Environment variables prefixed with "ZBX_CONF_" will be written to /etc/zabbix/zabbix_agentd.d/80-env-generated.conf (override by setting ZBX_CONFIGFILE).  
ZBX_CONF_ServerActive=proxy02,server01 => ServerActive=proxy02,server01  
To support multiple UserParameter settings "_[0-9]*" will be cut from the end.

## From cloud-config
```
#cloud-config

coreos:
  units:
    - name: zabbix-agentd.service
      command: start
      content: |
        [Unit]
        Description=Zabbix Monitor Agent
        Documentation=https://www.zabbix.com/documentation/3.0/manual/concepts/agent
        [Service]
        Environment=ZBX_CONF_Server=proxy02,server01
        Environment=ZBX_CONF_ServerActive=proxy02
        Environment=ZBX_CONF_UserParameter_1="mysql.ping,HOME=/var/lib/zabbix mysqladmin ping | grep -c alive"
        Environment=ZBX_CONF_UserParameter_2="mysql.ping2,HOME=/var/lib/zabbix mysqladmin ping | grep -c alive"
        Restart=always
        ExecStartPre=-/usr/bin/docker rm zabbix-agentd
        ExecStart=/usr/bin/docker run --net=host --name zabbix-agentd godmodelabs/zabbix-agentd
        ExecStop=-/usr/bin/docker stop zabbix-agentd
        ExecStopPost=-/usr/bin/docker rm zabbix-agentd
```
