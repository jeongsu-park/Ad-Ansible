## Role Name 
This Repository provide information on managing windows hosts with Ansible 

## Requirements
 1. To connect to a Windows server, you have to run the winrm services.
    * [WinRM Setup](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html#winrm-setup)
    
 2. TO use this playbook, run the following in Ansible 2.5 version.
    * Ansible will automatically reboot the remote host if it is required and continue to install updates after the reboot.
      This can be used instead of using a [win_reboot] task after this one and ensures all updates for that category is
      installed in one go.
      Async does not work when `reboot=True'.
      [Default: no]
      type: bool
      version_added: 2.5
      
## Role Variables 
```
```
## Dependencies
None

## Example Playbook
```---
- name: update windows patch
  #hosts: "{{ vmname }}"
  hosts: all
  gather_facts: false
  tasks:
    - name: search windows update
      win_updates:
        category_names: "{{ item }}"
        reboot: yes
        state: installed
        log_path: c:/ansible_wu.txt
      register: result
      with_items:
        - 'SecurityUpdates'
        - 'CriticalUpdates'
        - 'UpdateRollups'
        - 'Application'
        - 'DefinitionUpdates'

    - name: print result
      debug: msg={{ result }}

    - name: update windows patch
      #win_updates: category_names=SecurityUpdates
      #win_updates: category_names=CriticalUpdates
      win_updates:
      register: update_result

    - name: reboot when needed
      win_reboot:
        pre_reboot_delay: 15
        shutdown_timeout: 15
        reboot_timeout: 120
      when: '(update_result.failed is defined and update_result.failed == True) or (update_result.reboot_required is defined and update_result.reboot_required) or (update_result.failed_updated_count is defined and update_result.failed_update_count > 0)'

```  
## License
GNU General Public License v3.0 

## Author Information
Jeongsu Park.
 * jparks4056 [at] gmail.com
 
