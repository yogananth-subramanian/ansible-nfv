#!/bin/bash
ansible-playbook -i inventory  playbooks/tripleo/post_install/openstack_tasks.yml  --extra @debug.trexvar.yml -e resource_state=absent
