# Network
## Description
Defines internal, external and management network based on `netprefix` value.
## Invocation
Sample playbook which attempts to create external network.
````
- name: Include role to create external network
  include_role:
    name: osp/common
    tasks_from: network.yml
  vars:
    network_name: "{{network_external}}"
    physical_network_name: "{{ network_external.physical_network }}" 
    netprefix: "extern"
````
## Role Task Variables
Task variables are expected to be passed on by [osp/common](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/roles/osp/common/tasks/main.yml)
