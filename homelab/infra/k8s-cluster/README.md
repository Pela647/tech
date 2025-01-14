#### Prerequsites
1 - `talos` should be downloaded and available e.g. `metal-amd64.iso`. It can be downloaded from [here](https://github.com/siderolabs/talos/releases/tag/v1.9.1).  
2 - Update `Vagrantfile` with local path to `talos`.  
3 - `talosctl` installed. It can be installed using `$ brew install siderolabs/tap/talosctl` or downloaded from [here](https://github.com/siderolabs/talos/releases/tag/v1.9.1).  

#### Provisioning k8s cluster
- [Reference](https://www.talos.dev/v1.9/talos-guides/install/virtualized-platforms/vagrant-libvirt/)
- Edit `Vagrantfile`
- `$ vagrant up`
- `$ virsh list | grep k8s | awk '{print $2}' | xargs -t -L1 virsh domifaddr` = Find out the IP addresses assigned by the libvirt DHCP, this command should return a result similar to this:
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
- Pick an endpoint IP in the vagrant-libvirt subnet but not used by any nodes, for example 192.168.121.100 = `$ talosctl gen config homelab-cluster https://192.168.121.130:6443 --output-dir homelab-cluster` = this command should return:
```
generating PKI and tokens
Created homelab-cluster/controlplane.yaml
Created homelab-cluster/worker.yaml
Created homelab-cluster/talosconfig
```
- Add controlplane instance to k8s cluster
```
$ cd homelab-cluster
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



#### Vagrant commands reference
```
vagrant init = Initializes a new Vagrantfile in the current directory (not necessary if a custom Vagrantfile is already available).
vagrant up = Starts and provisions the Vagrant environment.
vagrant halt = Stops the running Vagrant machine.
vagrant reload = Restarts the Vagrant machine and applies changes to the Vagrantfile.
vagrant destroy = Stops and deletes all traces of the Vagrant machine.
vagrant status = Shows the status of the Vagrant environment.
```
