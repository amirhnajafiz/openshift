#!/bin/bash

# Set variables
INVENTORY_FILE="inventory/hosts"
PLAYBOOK_FILE="playbook.yml"
ANSIBLE_CFG_FILE="ansible.cfg"

# Check if Ansible is installed
if ! command -v ansible-playbook &> /dev/null
then
    echo "Ansible is not installed. Please install Ansible first."
    exit 1
fi

# Run the Ansible playbook
ansible-playbook -i $INVENTORY_FILE $PLAYBOOK_FILE --extra-vars "@/path/to/vars.yml"

# Check the result of the ansible-playbook command
if [ $? -ne 0 ]; then
    echo "Ansible playbook execution failed."
    exit 1
else
    echo "Ansible playbook executed successfully."
fi
