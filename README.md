# Openshift

Setting up an **Openshift** cluster, wich **Cilium** plugin, **Keycloak** and **ArgoCD**.

In order to setup the cluster, I used an ansible playbook. You can run the playbook by running `bootstrap.sh` script. Also, make sure to edit all files in `group_vars` and `inventory` direcotires.

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

Please ensure that your DNS records are correctly set up to resolve these addresses to the appropriate IPs of your OpenShift cluster and that the services are properly exposed. If you have configured custom routes or different namespaces, adjust the addresses accordingly.
