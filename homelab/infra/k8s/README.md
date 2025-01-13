#### Prerequsites
1 - `talos` should be downloaded and available e.g. `metal-amd64.iso`. It can be downloaded from [here](https://github.com/siderolabs/talos/releases/tag/v1.9.1).  
2 - Update `Vagrantfile` with local path to `talos`.  
3 - `talosctl` installed. It can be installed using `$ brew install siderolabs/tap/talosctl` or downloaded from [here](https://github.com/siderolabs/talos/releases/tag/v1.9.1).  

#### Provisioning k8s cluster
- [Reference](https://www.talos.dev/v1.9/talos-guides/install/virtualized-platforms/vagrant-libvirt/)


#### Vagrant commands reference
```
vagrant init = Initializes a new Vagrantfile in the current directory (not necessary if a custom Vagrantfile is already available).
vagrant up = Starts and provisions the Vagrant environment.
vagrant halt = Stops the running Vagrant machine.
vagrant reload = Restarts the Vagrant machine and applies changes to the Vagrantfile.
vagrant destroy = Stops and deletes all traces of the Vagrant machine.
vagrant status = Shows the status of the Vagrant environment.
```
