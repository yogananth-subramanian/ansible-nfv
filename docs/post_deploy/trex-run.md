 # trex-run
## Description
Runs Physical to Virtual back to Physical(PVP) RFC 2544 benchmark scenario using Software traffic generator (TRex).By default,it will determine the maximum throughput that could be attained with zero packet loss using frame size of 64 and number of flows set to 1.

This playbook calls on [ovs-dpdk](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/suite/ovs-dpdk.yaml) and [sriov playbook](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/suite/sriov-vf.yaml) depending upon user input to generate [Cloud Resources file](https://github.com/redhat-openstack/ansible-nfv/blob/master/docs/packet_gen/trex/performance_scenario.md#create-cloud-resources) and passes it on to performance playbook to trigger TRex.

## Invocation
The playbook requires 3 variables to be set in [trexvar.yml](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/trex.yaml), as mentioned below, to generated the appropriate Cloud Resource file.

Optionally `build_image` can be set to `true` to prepares a [centos cloud based image](https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2) with dpdk and TRex, using the [prepare_performance_images.yml](https://github.com/redhat-openstack/ansible-nfv/blob/master/docs/images/prepare_performance_images.md)
 
## Playbook variables
Playbook variables are defined in [trexvar.yml](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/trex.yaml)
 ### Networks
 external network configured in Openstack

 **Not** defined by default.
 ````
 extern: 'datacenter'
 ````
 Provider network
 SRIOV physical interface for TRex

 **Not** defined by default.
 ````
 physical_network_pf: ['sriov1', 'sriov2']
 ````
 Interface for testpmd. Based on whether ovs-dpdk or VF is used for testpmd, either physical_network_dpdk or physical_network_vf need to be set.


 **Not** defined by default.
 ````
 physical_network_dpdk: ['data1','data2']
 physical_network_vf:  ['sriov1', 'sriov2']
 ````

 Management network (**optional**)

 Management network for guest VMs, based on provider network. Could be used if dpdk based vxlan is not present in  ovsdpdkcompute node

 **Not** defined by default.
 ````
 mgmt: #'data1'
 ````
 ### Image
 Prepares a centos cloud based image with dpdk and TRex.

 Default `False`.
 ````
 build_image: true
 ````


Trex DPDK, Testpmd Configuration Variables, required by [performance playbook](https://github.com/redhat-openstack/ansible-nfv/blob/master/docs/packet_gen/trex/performance_scenario.md) can be overridden by setting up in [trexvar.yml](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/trex.yaml).

## Example
Examples of running this playbook:

Sample variable file [trexvar.yml](https://github.com/yogananth-subramanian/ansible-nfv/blob/master/user-specific/trex.yaml) passed on to playbook.

````
extern: 'datacentre'
mgmt: 'data1'

physical_network_dpdk: ['data1','data2']
physical_network_pf: ['sriov1', 'sriov2']
````

````
ansible-playbook -i inventory  trex-run.yaml  --extra @user-specific/trex.yaml -e build_image=true -vvv
````
