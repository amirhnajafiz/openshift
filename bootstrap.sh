#!/bin/bash

# Function to display help message
function usage() {
    echo "Usage: $0 -p PULL_SECRET_PATH -k SSH_KEY_PATH -b BASE_DOMAIN -c CLUSTER_NAME -r KEYCLOAK_REALM -i KEYCLOAK_CLIENT_ID -s KEYCLOAK_CLIENT_SECRET"
    exit 1
}

# Parse command-line arguments
while getopts "p:k:b:c:r:i:s:" opt; do
  case $opt in
    p) PULL_SECRET_PATH=$OPTARG ;;
    k) SSH_KEY_PATH=$OPTARG ;;
    b) BASE_DOMAIN=$OPTARG ;;
    c) CLUSTER_NAME=$OPTARG ;;
    r) KEYCLOAK_REALM=$OPTARG ;;
    i) KEYCLOAK_CLIENT_ID=$OPTARG ;;
    s) KEYCLOAK_CLIENT_SECRET=$OPTARG ;;
    *) usage ;;
  esac
done

# Ensure all required arguments are provided
if [ -z "$PULL_SECRET_PATH" ] || [ -z "$SSH_KEY_PATH" ] || [ -z "$BASE_DOMAIN" ] || [ -z "$CLUSTER_NAME" ] || [ -z "$KEYCLOAK_REALM" ] || [ -z "$KEYCLOAK_CLIENT_ID" ] || [ -z "$KEYCLOAK_CLIENT_SECRET" ]; then
    usage
fi

# Set default values for optional parameters
K8S_SERVICE_PORT=${K8S_SERVICE_PORT:-6443}
K8S_SERVICE_HOST="api.${CLUSTER_NAME}.${BASE_DOMAIN}"
KEYCLOAK_URL="keycloak.${BASE_DOMAIN}"

# Create group_vars directory if it doesn't exist
mkdir -p group_vars

# Generate group_vars/all.yml dynamically
cat <<EOF > group_vars/all.yml
---
pull_secret_path: "$PULL_SECRET_PATH"
ssh_key_path: "$SSH_KEY_PATH"
base_domain: "$BASE_DOMAIN"
cluster_name: "$CLUSTER_NAME"
k8s_service_host: "$K8S_SERVICE_HOST"
k8s_service_port: $K8S_SERVICE_PORT
keycloak_url: "$KEYCLOAK_URL"
keycloak_realm: "$KEYCLOAK_REALM"
keycloak_client_id: "$KEYCLOAK_CLIENT_ID"
keycloak_client_secret: "$KEYCLOAK_CLIENT_SECRET"
EOF

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
ansible-playbook -i $INVENTORY_FILE $PLAYBOOK_FILE

# Check the result of the ansible-playbook command
if [ $? -ne 0 ]; then
    echo "Ansible playbook execution failed."
    exit 1
else
    echo "Ansible playbook executed successfully."
fi
