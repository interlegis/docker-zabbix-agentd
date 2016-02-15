# docker-zabbix-agentd
A Debian latest based Docker container running zabbix_agentd in a CoreOS instance. 


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
        Documentation=https://www.zabbix.com/documentation/2.4/manual/concepts/agent
        [Service]
        Restart=always
        ExecStartPre=-/usr/bin/docker rm zabbix-agentd
        ExecStart=/usr/bin/docker run --net=host --name zabbix-agentd godmodelabs/zabbix-agentd
        ExecStop=-/usr/bin/docker stop zabbix-agentd
        ExecStopPost=-/usr/bin/docker rm zabbix-agentd
```
