#### References
- Mint optimization after fresh install [link](https://www.youtube.com/watch?v=kV8Hu54zhbA).
- How to install [QEMU/KVM](https://forums.linuxmint.com/viewtopic.php?t=428069), then restart device.

#### How to install Windows 11 as VM:
    - Download Windows 11 iso file or create installation media [here](https://www.microsoft.com/en-us/software-download/windows11)
    - Download `latest virtio-win ISO` [here](https://github.com/virtio-win/virtio-win-pkg-scripts?tab=readme-ov-file#downloads)
    - Follow installation instructions [here](https://www.youtube.com/watch?v=WmFpwpW6Xko)
    - For VM full screen experience, install Guest agent (should be under the virtio ISO file `virtio-win-guest-tools`), it should also install `spice-guest-tools` if not download and install from [here](https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe), it is necessary to copy/paste text between machine and VM.

#### How to create shared dir between Win VM and Mint Host
- Install `virtiofsd` in Host
```
sudo apt update
sudo apt install qemu-system
sudo apt install qemu-utils
find /usr -name virtiofsd 2>/dev/null  ===> Get location 
export PATH=$PATH:/path/to/virtiofsd-directory  ===> Add to path
```
- From virtual machine manager:
```
Add Hardware -> File system, 
Driver = virtiofs
Source path: `Host OS full dir path` 
Target path: any (this is just mount name)
```
- Start VM 
- In Win VM, both WinFSP and virtiofs drivers are necessary and Virtio-FS service should be running. Instructions [link](https://github.com/virtio-win/kvm-guest-drivers-windows/wiki/Virtiofs:-Shared-file-system#guest)
- Click `This PC` (file explorer) and shared dir should appear as drive `Z`. 

#### Troubleshooting

1 - 
Issue:
```
unable to launch "cinnamon-session-cinnamon", session "cinnamon-session-cinnamon" not found, failing back to default session.
```
Solution:
- Click `Ctrl+Alt+F1`, login using username/password and then run
```
sudo apt-get update
sudo apt-get install nemo
sudo apt-get install cinnamon
```
2 - Issue: Missing bluetooth manager
Solution: 
```
sudo apt install blueman
sudo systemctl restart bluetooth.service
```
Restart device
