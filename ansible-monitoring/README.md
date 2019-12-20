## Role Name 
To send emails from playbooks when they do Not match: ansible_play_hosts and ansible_play_hosts_all

## Requirements
 1. These variables cannot be set directly by the user; Ansible will always override them to reflect internal state.
    * [Special Variables](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html?highlight=ansible_play_hosts)
 
## Role Variables 
```javascript
tasks:
  block:
  command: echo "Chekcing ping"
    - assert:
        that:
          - ansible_play_hosts == ansible_play_hosts_all

  rescue:
    - name: Sending an e-mail using Gmail SMTP servers
      mail:
        host: smtp.gmail.com
        port: 465
        username: jparks4056@gmail.com
        password: "{{ password }}"
        to: jeong su <jparks4056@gmail.com>
        subject: Host check- {{ (ansible_play_hosts_all | difference(ansible_play_hosts)) }}
        secure: starttls
        timeout: 60
        body: Can not login into the machine, Host check- {{ (ansible_play_hosts_all | difference(ansible_play_hosts )) }}
      when: inventory_hostname == "localhost"

```
## Dependencies
None

## Example Playbook
```javascript
- hosts: all 
  become: true
  vars:
  roles:
    - role: ansible-monitoring
  tasks: 
```  
## License
BSD

## Author Information
Jeongsu Park.
 * jparks4056 [at] gmail.com
 
