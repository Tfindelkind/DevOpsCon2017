#!/bin/bash
cd ~/work/src/github.com/Tfindelkind/DCI/
CONFIG_PATH='/home/tfindelkind/work/src/github.com/Tfindelkind/DevOpsCon2017'
echo $CONFIG_PATH/config.ucp1
./dci.sh --recipe=DOCKER-EE --rv=v1 --ros=CentOS7 --host=192.168.178.130 --config=$CONFIG_PATH/config.ucp1 --username=admin --password=nutanix/4u --container=prod --vlan=VLAN0 --vm-name=ucp1
./dci.sh --recipe=DOCKER-EE --rv=v1 --ros=CentOS7 --host=192.168.178.130 --config=$CONFIG_PATH/config.ucp2 --username=admin --password=nutanix/4u --container=prod --vlan=VLAN0 --vm-name=ucp2
./dci.sh --recipe=DOCKER-EE --rv=v1 --ros=CentOS7 --host=192.168.178.130 --config=$CONFIG_PATH/config.ucp3 --username=admin --password=nutanix/4u --container=prod --vlan=VLAN0 --vm-name=ucp3
./dci.sh --recipe=DOCKER-EE --rv=v1 --ros=CentOS7 --host=192.168.178.130 --config=$CONFIG_PATH/config.ucp4 --username=admin --password=nutanix/4u --container=prod --vlan=VLAN0 --vm-name=ucp4
