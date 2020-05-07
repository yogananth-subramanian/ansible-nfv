# OSP
## Description
Uses the plan environment file to determine network ip range and vlan values to uses, while creating external, management and internal network. Role [osp/common/network](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/roles/osp/common/tasks/network.yml) is used to create the required network format.


## Invocation

Sample playbook which attempts to create external and management network for trex VM.

````
---
- hosts: undercloud 
  roles:
    - role: osp/common
      port_type: 'normal'
      prefix: 'trex'
````

## Role Variables

Role expects network variables passed to [trex-run](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/trex.yaml) and [tempest-run](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/tempest.yaml) playbook and bellow set of variables

Port type of the network

**Not** defined by default.
````
port_type: 'normal'
````

Type of test being run

**Not** defined by default.
````
prefix: 'trex'
````

### Role default variables
[Cloud Resources file](https://github.com/redhat-openstack/ansible-nfv/blob/master/docs/packet_gen/trex/performance_scenario.md#create-cloud-resources) that are required for performance and NFV Tempest tests are defined in the default.

