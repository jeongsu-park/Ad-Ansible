## Role Name 
An ansible role to automate install and manage using redfish + cobbler 

## Requirements
 1. The Machine to be install need to support redfish API such as dell iDrac or ibm imm 
    * [Dell Redfish API Reference Guide](https://www.dell.com/support/article/kr/ko/krdhs1/sln310624/redfish?lang=en)
    * [IBM Redfish API REference Guide](https://sysmgt.lenovofiles.com/help/topic/com.lenovo.systems.management.xcc.doc/REST_API_user_manual.pdf)
 2. Should be installed cobbler server
    * [Cobbler Installation](https://cobbler-doc.readthedocs.io/en/latest/installation.html)
 
## Role Variables 
```javascript
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
```
## Dependencies
None

## Example Playbook
```javascript
- hosts: all 
  become: true
  vars:
  roles:
    - role: ansible-baremetal
  tasks: 
```  
## License
BSD

## Author Information
Jeongsu Park.
 * jparks4056 [at] gmail.com
 
