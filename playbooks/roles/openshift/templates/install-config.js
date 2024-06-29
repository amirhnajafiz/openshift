apiVersion: v1
baseDomain: amirnajafiz.ir
compute:
- hyperthreading: Enabled
  name: worker
  replicas: 1
controlPlane:
  hyperthreading: Enabled
  name: master
  replicas: 1
metadata:
  name: ocp4
networking:
  clusterNetwork:
  - cidr: 10.128.0.0/14
    hostPrefix: 23
  networkType: OpenShiftSDN
  serviceNetwork:
  - 172.30.0.0/16
platform:
  none: {}
pullSecret: '{{ lookup("file", "/path/to/pull-secret.txt") }}'
sshKey: '{{ lookup("file", "/path/to/ssh-key.pub") }}'
