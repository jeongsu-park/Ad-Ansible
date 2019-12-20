#!/bin/bash

NIC1=`curl -s -u USERID:PASSW0RD -k https://192.168.0.10/redfish/v1/Systems/1/EthernetInterfaces/1 | python -m json.tool | jq '.PermanentMACAddress'`
NIC2=`curl -s -u USERID:PASSW0RD -k https://192.168.0.11/redfish/v1/Systems/1/EthernetInterfaces/1 | python -m json.tool | jq '.PermanentMACAddress'`

DHCP_IP1=192.168.0.171
DHCP_IP2=192.168.0.172

HOST_NAME1=kolon1
HOST_NAME2=kolon2

for i in "$NIC1"
do
  echo "---" > lenovo.yml
  echo "hosts:" >> lenovo.yml
  echo "  - HOST_NAME: $HOST_NAME1" >> lenovo.yml
  echo "    DHCP_MAC: $i" >> lenovo.yml
  echo "    DHCP_IP: $DHCP_IP1" >> lenovo.yml
    for u in "$NIC2"
    do
      echo "  - HOST_NAME: $HOST_NAME2" >> lenovo.yml
      echo "    DHCP_MAC: $u" >> lenovo.yml
      echo "    DHCP_IP: $DHCP_IP2" >> lenovo.yml
    done
done
