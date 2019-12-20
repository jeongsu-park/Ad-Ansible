## Role Name 
An ansible role to create new virtual machines from templates or other virtual machines

## Requirements
 1. python >=2.6, PyVmomi
    * [VMware community wiki](https://github.com/ansible/community/wiki/VMware)
 
## Role Variables 
Unlike Linux, you can expand the volume with the following Power Shell command.


```javascript

 - powershell.exe Resize-Partition -DriveLetter C -Size (Get-PartitionSupportedSize -DriveLetter C).sizeMax
 - powershell.exe Resize-Partition -DriveLetter D -Size (Get-PartitionSupportedSize -DriveLetter D).sizeMax

```
## Dependencies
None

## Example Playbook
```javascript
- hosts: all 
  become: true
  vars:
  roles:
    - role: ansible-virtualization
  tasks: 
```  
## License
GNU General Public License v3.0 

## Author Information
Jeongsu Park.
 * jparks4056 [at] gmail.com
