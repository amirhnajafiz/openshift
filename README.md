# Openshift

Setting up an **Openshift** cluster, wich **Cilium** plugin, **Keycloak** and **ArgoCD**.

In order to setup the cluster, I used an ansible playbook. You can run the playbook by running `bootstrap.sh` script. Also, make sure to edit all files in `inventory` direcotires.

## Prerequisites

- Ensure you have Ansible installed on your machine.
- Make sure you have SSH access to your OpenShift nodes.
- Obtain the necessary credentials and secrets for your OpenShift and Keycloak setup.

## Run bootstrap

This setup allows you to dynamically set the values in group_vars/all.yml from the shell script, providing flexibility to configure the playbook execution as needed.

```sh
./botstrap.sh -p /new/path/to/pull-secret.txt -k /new/path/to/ssh-key.pub -b newdomain.com -c new_cluster_name -r new_realm -i new_client_id -s new_client_secret
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
