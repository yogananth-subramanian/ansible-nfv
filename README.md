# Ansible NFV playbooks
Ansible NFV repository holds various playbooks for installation, configuration, tuning, testing and day to day tasks related to NFV and Openstack.

## TReX Execution
* “**pip install netaddr**”
* Initialize ansible inventory.

  For hybrid environment:
  Run below command from Hypervisor host with "-e host=" set to Hypervisor host IP.
  
  **ansible-playbook initialize.yaml -e host=HypervisorIP -e user=root -e ssh_key=~/.ssh/id_rsa -e setup_type=virt**
* To start execution of trex benchmark, run:
  
  **ansible-playbook -i inventory  trex-run.yaml  --extra @user-specific/trex.yaml**
  
  user-specific/trex.yaml defines the minimal set of parameters related to external, management and provider network.
  * Only 3 mandatory variables need to be set:
    * **extern** to specify the external network configured in Openstack, 
    * **physical_network_pf** for specifying the SRIOV physical interface for TRex.
    * Interface  for testpmd ( **physical_network_dpdk** or  **physical_network_vf**).

* To cleanup trex resources, run:
  **trex_cleanup.sh**
  ## Tempest Execution
* “**pip install netaddr**”
* Initialize ansible inventory.

  For hybrid environment:
  Run below command from Hypervisor host with "-e host=" set to Hypervisor host IP.
  
  **ansible-playbook initialize.yaml -e host=HypervisorIP -e user=root -e ssh_key=~/.ssh/id_rsa -e setup_type=virt**
* To start execution of tempest tests, run:
  
  **ansible-playbook -i inventory  tempest-run.yaml  --extra @user-specific/tempest.yaml**
  
  user-specific/trex.yaml defines the minimal set of parameters related to external, management and provider network.
  * Only 2 mandatory variables need to be set:
    * **extern** to specify the external network configured in Openstack, 
    * Interfaces to use with tempest ( **physical_network_dpdk** or  **physical_network_vf** or **physical_network_pf**).

* To cleanup tempest resources,run:
  **tempest_cleanup.sh**
## Examples of Physical to Virtual back to Physical(PVP) senarios
## Senarios 1 - Device Under Test (DUT) backed by DPDK


```+----------------------+
|  +----------------+  |
|  |  Testpmd VM    |  |
|  +-+------------+-+  |
|    |            |    |
| +--+------------+--+ |
| |    OVS DPDK      | |
| +--+------------+--+ |
|    |            |    |
|    | Compute 1  |    |
|  +-+-+        +-+-+  |
|  |   |        |   |  |
+--+-+-+--------+-+-+--+
     |            |
+----+------------+----+
|      TOR Switch      |
|                      |
+----+------------+----+
     |            |
+----+------------+----+
| || P ||      || P || |
| || F ||      || F || |
| +--+--+      +--+--+ |
|    | Compute 2  |    |
| +--+------------+--+ |
| |                  | |
| |       TReX VM    | |
| +------------------+ |
+----------------------+

"OSP Network Info:",
"  Bridge Mappings:      datacentre:br-ex,data1:br-link0,data2:br-link1",
"  Network VLANRanges:   datacentre:1205:1210,data1:201:220,data2:201:220,sriov1:201:220,sriov2:201:220",
"  Flat Networks:        datacentre,data1,data2",
"  Physical Dev Mapping: sriov1:em1,sriov2:em2",
```
For the above network config, **user-specific/trex.yml** would be set as follows:

**extern: 'datacentre'** #[1]  
**mgmt: 'data1'**        #[2]  
**physical_network_dpdk: ['data1','data2']**  #[3]  
**physical_network_pf: ['sriov1', 'sriov2']** #[4]  

**[1]** The external floating network is mapped to **"datacenter"**, so **"extern"** is set to datacentre.    
**[2]** Since the DPDK Compute1 node does not have DPDK-VXLAN network, one of provider network **"data1"** is used as management network for the Testpmd VM, hence **"mgmt"** is set to data1. On compute2 a VXLAN network would be created for use as management.  
**[3]** Provider network based on **"data1"** and **"data2"**, within the VLANRanges, will be created on Compute1.  
**[4]** Provider network based on **"sriov1"** and **"sriov2"** will be created on Compute2.  

## Senarios 2 - Device Under Test (DUT) backed by SRIOV-VF

```+----------------------+
|  +----------------+  |
|  |   Testpmd VM   |  |
|  +-+------------+-+  |
|    |            |    |
|    | Compute 1  |    |
| +--+--+      +--+--+ |
| ||V  ||      || V || |
| ||F  ||      || F || |
+----+------------+----+
     |            |
+----+------------+----+
|         TOR Switch   |
|                      |
+----+------------+----+
     |            |
+----+------------+----+
| || P ||      || P || |
| || F ||      || F || |
| +--+--+      +--+--+ |
|    | Compute 2  |    |
| +--+------------+--+ |
| |                  | |
| |    TReX  VM      | |
| +------------------+ |
+----------------------+

```


## Documentation
For the repository documentation, refer to the **docs** directory, which provide explanation regarding the playbooks.  
In order to start working with TripleO environment, refer to the following doc - **docs/tripleo/post_install/tripleo_inventory.md**.  
The playbook will generate an inventory file for the tripleo environment.

**The minimum required version of Ansible for the playbooks >=2.7.5,<2.8.0**  
**Note** - In order to work properly with the selinux, make sure the **libselinux-python** package is installed on your host.

## Playbooks
* TripleO
    * Tester
      * Tempest
      * Testpmd deploy and MoonGen run
      * Testpmd deploy and MoonGen run on secondary NUMA node
    * Tuning
      * CPU pinning and Huge pages
      * Tuned
    * Post install
      * Openstack tasks
      * Overcloud repo install
      * TripleO Inventory
    * Configuration
      * Config NFV Lab switches
      * Interact with Dell EMC iDRAC:
        * Power Actions
        * Query information
        * Set device boot order
* Moongen
    * Moongen install
    * Moongen run

## How to contribue
Patches should be submitted using git review to the GerritHub.

## Note
Please, modify the playbooks variables to meet your needs before running the playbooks.

The variables could be applied to the playbook run, by saving them into a separate yml file and include the file during the playbook execution.  
Note the '@' sign, which is used to apply the variables located within the provided file.

```
ansible-playbook playbooks/path/to/the/playbook.yml -e @/path/to/the/variable/file.yml
```

For any question, refer to the NFV Cloud QE team - nfv-cloud-qe-team@redhat.com
