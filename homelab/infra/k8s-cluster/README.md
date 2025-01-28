### Prerequisites
1 - `talos` should be downloaded and available e.g. `metal-amd64.iso`. It can be downloaded from [here](https://github.com/siderolabs/talos/releases/tag/v1.9.1).  
2 - Update `Vagrantfile` with local path to `talos`.  
3 - `talosctl` installed. It can be installed using `$ brew install siderolabs/tap/talosctl` or downloaded from [here](https://github.com/siderolabs/talos/releases/tag/v1.9.1).  

### Provisioning k8s cluster
- [Reference](https://www.talos.dev/v1.9/talos-guides/install/virtualized-platforms/vagrant-libvirt/)
- Edit `Vagrantfile`  
- `$ vagrant up` 
- `$ virsh list | grep node | awk '{print $2}' | xargs -t -L1 virsh domifaddr` = Find out the IP addresses assigned by the libvirt DHCP, this command should return a result similar to this:
```
virsh domifaddr k8s-cluster_worker-node-1
 Name       MAC address          Protocol     Address
-------------------------------------------------------------------------------
 vnet8      52:54:00:9d:7a:60    ipv4         192.168.121.194/24

virsh domifaddr k8s-cluster_worker-node-2
 Name       MAC address          Protocol     Address
-------------------------------------------------------------------------------
 vnet9      52:54:00:b6:d3:3d    ipv4         192.168.121.91/24

virsh domifaddr k8s-cluster_worker-node-3
 Name       MAC address          Protocol     Address
-------------------------------------------------------------------------------
 vnet10     52:54:00:95:31:13    ipv4         192.168.121.82/24

virsh domifaddr k8s-cluster_control-plane-node-1
 Name       MAC address          Protocol     Address
-------------------------------------------------------------------------------
 vnet11     52:54:00:bc:a4:21    ipv4         192.168.121.130/24

```
- Pick an endpoint IP in the vagrant-libvirt subnet but not used by any nodes, for example 192.168.121.100
```
$ talosctl gen config main-cluster https://192.168.121.100:6443 --output-dir main-cluster
``` 
- Above command will return:
```
generating PKI and tokens
Created main-cluster/controlplane.yaml
Created main-cluster/worker.yaml
Created main-cluster/talosconfig
```
- To enable kubelet certificate rotation, all nodes should have the following Machine Config snippet (necessary for metrics-server deployment). Add this config to both `controlplane.yaml` and `worker.yaml` files.
```
machine:
  kubelet:
    extraArgs:
      rotate-server-certificates: true
```
- Add controlplane instance to k8s cluster
```
$ cd main-cluster
$ talosctl apply-config --insecure --nodes 192.168.121.130 --file controlplane.yaml
```
- Add worker node instances to k8s cluster
```
$ talosctl apply-config --insecure --nodes 192.168.121.194 --file worker.yaml
$ talosctl apply-config --insecure --nodes 192.168.121.91 --file worker.yaml
$ talosctl apply-config --insecure --nodes 192.168.121.82 --file worker.yaml
```
- Set up current shell to use the generated talosconfig and configure its endpoints (use the IPs of the control plane node(s)):
```
$ export TALOSCONFIG=$(realpath ./talosconfig)
talosctl config endpoint 192.168.121.130
```
- Bootstrap the Kubernetes cluster from the initial control plane node: `talosctl bootstrap -n 192.168.121.130`
- Get kubeconfig `talosctl kubeconfig .`

- Retrieve the kubeconfig from the cluster:
```
$ talosctl -n 192.168.121.130 kubeconfig ./kubeconfig
```
- List the nodes in the cluster:
```
$ kubectl --kubeconfig ./kubeconfig get node -owide
```
Output should be similar to this:
```
NAME            STATUS   ROLES           AGE     VERSION   INTERNAL-IP       EXTERNAL-IP   OS-IMAGE         KERNEL-VERSION   CONTAINER-RUNTIME
talos-3i3-7c9   Ready    <none>          2m35s   v1.32.0   192.168.121.91    <none>        Talos (v1.9.1)   6.12.6-talos     containerd://2.0.1
talos-h6p-349   Ready    <none>          2m19s   v1.32.0   192.168.121.82    <none>        Talos (v1.9.1)   6.12.6-talos     containerd://2.0.1
talos-k52-qc8   Ready    <none>          2m21s   v1.32.0   192.168.121.194   <none>        Talos (v1.9.1)   6.12.6-talos     containerd://2.0.1
talos-z61-gcj   Ready    control-plane   3m46s   v1.32.0   192.168.121.130   <none>        Talos (v1.9.1)   6.12.6-talos     containerd://2.0.1
```
### Vagrant commands reference
```
vagrant init = Initializes a new Vagrantfile in the current directory (not necessary if a custom Vagrantfile is already available).
vagrant up = Starts and provisions the Vagrant environment.
vagrant halt = Stops the running Vagrant machine.
vagrant reload = Restarts the Vagrant machine and applies changes to the Vagrantfile.
vagrant destroy = Stops and deletes all traces of the Vagrant machine.
vagrant status = Shows the status of the Vagrant environment.
```
