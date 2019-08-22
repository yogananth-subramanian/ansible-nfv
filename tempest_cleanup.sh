#!/bin/bash
ansible-playbook -i inventory  playbooks/tripleo/post_install/openstack_tasks.yml  --extra @playbooks/tripleo/tester/tempestvar.yml -e resource_state=absent

