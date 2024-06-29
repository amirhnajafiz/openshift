# Openshift

Setting up an **Openshift** cluster, wich **Cilium** plugin, **Keycloak** and **ArgoCD**.

In order to setup the cluster, I used an ansible playbook. You can run the playbook by running `bootstrap.sh` script. Also, make sure to edit all files in `inventory` direcotires.

## Prerequisites

- Ensure you have Ansible installed on your machine.
- Make sure you have SSH access to your OpenShift nodes.
- Obtain the necessary credentials and secrets for your OpenShift and Keycloak setup.

## Run bootstrap

This setup allows you to dynamically set the values in `group_vars/all.yml` from the shell script, providing flexibility to configure the playbook execution as needed.

```sh
./bootstrap.sh -p /new/path/to/pull-secret.txt -k /new/path/to/ssh-key.pub -b newdomain.com -c new_cluster_name -r new_realm -i new_client_id -s new_client_secret
```

### Command-Line Arguments

| Argument          | Description                                      | Example                              |
|-------------------|--------------------------------------------------|--------------------------------------|
| `-p`              | Path to the pull secret file                     | `/path/to/pull-secret.txt`           |
| `-k`              | Path to the SSH key file                         | `/path/to/ssh-key.pub`               |
| `-b`              | Base domain for the cluster                      | `example.com`                        |
| `-c`              | Cluster name                                     | `my_cluster`                         |
| `-r`              | Keycloak realm                                   | `my_realm`                           |
| `-i`              | Keycloak client ID                               | `my_client_id`                       |
| `-s`              | Keycloak client secret                           | `my_client_secret`                   |

#### Variables

- pull_secret_path: This variable specifies the path to the pull secret file required by OpenShift during installation. The pull secret is used to authenticate with Red Hat's container registry to pull the necessary images for the OpenShift components. The value should be the absolute path to the pull secret file on your local machine. You can obtain the pull secret from the Red Hat OpenShift Cluster Manager.
- keycloak_realm: This variable specifies the name of the Keycloak realm to be used. A realm in Keycloak is a space where you manage objects like users, roles, and groups. Each realm is isolated from other realms.
- keycloak_client_id: This variable specifies the client ID configured in the Keycloak realm. The client ID is used to identify the application (in this case, OpenShift) to Keycloak. The value should be the client ID you have set up in Keycloak for your OpenShift application. This client ID should have the necessary roles and permissions configured for authentication and authorization purposes.
- keycloak_client_secret: This variable specifies the client secret associated with the client ID in Keycloak. The client secret is used for secure communication between OpenShift and Keycloak. The value should be the client secret generated in Keycloak for your OpenShift client. This secret must be kept secure and should not be exposed publicly.

## Access Points

After successfully setting up your OKD (OpenShift Origin) cluster with Keycloak and ArgoCD, you can access various services at the following addresses.

### OKD

Console Address:

```txt
https://console-openshift-console.apps.<base_domain>
```

API Address:

```txt
https://api.<cluster_name>.<base_domain>:6443
```

### ArgoCD

Service:

```txt
http://argocd-server-argocd.apps.<base_domain>
https://argocd-server-argocd.apps.<base_domain>
```

### Keycloak

Service:

```txt
http://keycloak.<base_domain>
```

### Cilium

Hubble UI:

```txt
http://hubble-ui.<base_domain>
https://hubble-ui.<base_domain>
```

Please ensure that your DNS records are correctly set up to resolve these addresses to the appropriate IPs of your OpenShift cluster and that the services are properly exposed. If you have configured custom routes or different namespaces, adjust the addresses accordingly.
