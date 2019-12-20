## Role Name 
To automate install and manage using docker containers : MariaDB, Wordpress

## Requirements
 1. Manage the life cycle of docker containers.
    * [docker image](https://www.docker.com/resources/what-container)
 
## Role Variables 
```javascript
```
## Dependencies
None

## Example Playbook
```javascript
- hosts: all 
  become: true
  vars:
  roles:
    - role: ansible-docker
  tasks: 
```  
## License
BSD

## Author Information
Jeongsu Park.
 * jparks4056 [at] gmail.com
