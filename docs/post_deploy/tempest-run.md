# tempest-run 
## Description
Runs NFV Tempest playbook, after creating the cloud resource specified by the user.

This playbook calls on tempest playbook depending upon user input (`physical_network_dpdk`, `physical_network_vf`, `physical_network_pf`)  to generate [Cloud Resources file](https://github.com/redhat-openstack/ansible-nfv/blob/master/docs/packet_gen/trex/performance_scenario.md#create-cloud-resources) and passes it on to tempest playbook to trigger NFV tempest.

## Invocation
The playbook requires 4 variables to be set in [tempestvar.yml](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/tempest.yaml), as mentioned below, to generated the appropriate Cloud Resource file and run tempest playbook.
 
## Playbook variables
Playbook variables are defined in [tempestvar.yml](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/tempest.yaml)
 ### Network
 external network configured in Openstack

 **Not** defined by default.
 ````
 extern: 'datacenter'
 ````
 Provider network
 Specifies SRIOV, VF or ovs-dpdk provider network to use with NFV Tempest tests.

   **Not** defined by default.
 ````
 physical_network_dpdk: ['data1','data2']
 physical_network_vf:  ['sriov1', 'sriov2']
 physical_network_pf: ['sriov1', 'sriov2']

 ````

 Management network (**optional**)

 Management network for guest VMs, based on provider network. Could be used if dpdk based vxlan is not present in  ovsdpdkcompute node

  **Not** defined by default.
 ````
 mgmt: #'data1'
 ````

 #### NFV Tempest
 List of [NFV tempest tests](https://github.com/redhat-openstack/nfv-tempest-plugin/blob/master/docs/tests.md) to run.
   **Not** defined by default.
 ````
tempest_tests:
  - nfv_tempest_plugin.tests.scenario.test_nfv_basic.TestNfvBasic.test_mtu_ping_test

 ````
 List of [test config](https://github.com/redhat-openstack/nfv-tempest-plugin/blob/master/docs/tests.md) to use for NFV Tempest test.
    **Not** defined by default.
 ````
tests_setup:
  - name: numa0
    flavor: perf_numa_0_trex
    router: true
  - name: test-ping-mtu
    flavor: perf_numa_0_trex
    router: true
    mtu: 1500
 ````

## Example
Examples of running this playbook:

Sample variable file [tempestvar.yml](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/tempest.yaml) passed on to playbook.

````
tests_setup:
  - name: numa0
    flavor: perf_numa_0_trex
    router: true
  - name: test-ping-mtu
    flavor: perf_numa_0_trex
    router: true
    mtu: 1500

tempest_tests:
  - nfv_tempest_plugin.tests.scenario.test_nfv_basic.TestNfvBasic.test_mtu_ping_test

extern: 'datacentre'
mgmt: 'data1'
physical_network_vf: ['sriov-1', 'sriov-2']
physical_network_dpdk: ['data1']
physical_network_pf: ['sriov-1', 'sriov-2']
````

````
ansible-playbook -i inventory tempest-run.yaml --extra @user-specific/tempest.yaml
````
