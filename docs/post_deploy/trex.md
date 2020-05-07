# trex
## Description
Calls on [osp/common/network](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/roles/osp/common/tasks/network.yml) to define  internal network for dpdk, PF and VF environment and define ports for the networks and calls on [osp/common/server](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/roles/osp/common/tasks/server.yml) to define aggregate groups and maps the networks to trex and testpmd instances.
## Invocation
Sample playbook which attempts to define testpmd instance.
````
    - role: trex/install
      physical_networks: "{{ physical_network_dpdk }}"
      port_type: 'normal'
      prefix: 'testpmd'
````
## Role Task Variables
Role expects network variables passed on to [trex-run](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/trex.yaml) playbook be set.
