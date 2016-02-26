#!/bin/bash

# generate config
config_file=${ZBX_CONFIGFILE:-/etc/zabbix/zabbix_agentd.d/80-env-generated.conf}

## get all variables prefixed with ZBX_CONF_
for env_zabbix_option in ${!ZBX_CONF_*}
do
    zabbix_option=${env_zabbix_option#ZBX_CONF_}
    zabbix_option=${zabbix_option%_[0-9]*}
    echo "${zabbix_option}=${!env_zabbix_option}"
done > "${config_file}"
# generate config -- end

# start agentd in foreground - has to be started as target user
/usr/sbin/zabbix_agentd
# agent process is forking to background
while pgrep zabbix_agentd > /dev/null; do sleep 1; done
