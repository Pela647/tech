### Notes
- Script to install apps/tools after fresh install of ubuntu/mint ... is `homelab/scripts/ubuntu-setup.sh`
- FUSE filesystem for Google Drive [google-drive-ocamlfuse](https://github.com/astrada/google-drive-ocamlfuse?tab=readme-ov-file#usage), needs `client-id` and `client-secret` which can be generated from `Google Drive API`, then `vi ~/.gdfuse/default/config` and replace <client-id> and <client-secret> with the actual values.
- Mint optimization after fresh install [link](https://www.youtube.com/watch?v=kV8Hu54zhbA).
- How to install [QEMU/KVM](https://forums.linuxmint.com/viewtopic.php?t=428069), then restart device.

### Starship (Prompt for any shell)
- `ubuntu-setup.sh` will install `Starship`
- Add `eval "$(starship init bash)"` to `~/.bashrc`.
- To display time taken by a command to complete, `vi ~/.config/starship.toml` and add the following to the file:
```
[cmd_duration]
min_time = 2000       # Show duration for commands longer than 2 seconds (in milliseconds)
format = "[took $duration]($style)"  # Customize the display format
style = "bold yellow" # Customize the style (e.g., color, bold)
show_milliseconds = true # Show milliseconds if needed
```

### How to install Windows 11 as VM
- Download Windows 11 iso file or create installation media [here](https://www.microsoft.com/en-us/software-download/windows11)
- Download `latest virtio-win ISO` [here](https://github.com/virtio-win/virtio-win-pkg-scripts?tab=readme-ov-file#downloads)
- Follow installation instructions [here](https://www.youtube.com/watch?v=WmFpwpW6Xko)
- For VM full screen experience, install Guest agent (should be under the virtio ISO file `virtio-win-guest-tools`), it should also install `spice-guest-tools` if not download and install from [here](https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe), it is necessary to copy/paste text between machine and VM.

### How to create shared dir between Win VM and Mint Host
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
- In Win VM, both `WinFSP` and `virtiofs` drivers are necessary and Virtio-FS service should be running. Instructions [here](https://github.com/virtio-win/kvm-guest-drivers-windows/wiki/Virtiofs:-Shared-file-system#guest).
- In Windows VM click `This PC` (file explorer) and shared dir should appear as drive `Z`. 

### Troubleshooting
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

3 - Issue: `sudo apt update` error
```
The repository 'https://apt.releases.hashicorp.com wilma Release' does not have a Release file.
```
Solution:
```
$ cat /etc/apt/sources.list.d/hashicorp.list
deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg]     https://apt.releases.hashicorp.com wilma main
```
- Replace wilma (`lsb_release -c`) with something else which supported by hashicorp, e.g. `jammy`.  

4 - Issue: `sudo apt update` error
```
GPG error: http://repository.spotify.com stable InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY C85668DF69375001
```
Solution: Fetch and add the missing public key.
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C85668DF69375001
```
### Installed apps
| Name | Installation method | Comment |
|----------|----------|----------|
| vscode  | software manager  | |  
| localSend   | software manager     | shares files to local devices|
| OBS   | software manager     | |
| Audacity   | software manager     | |
| Teams for Linux   | software manager     | |
| Inkscape   | software manager     | |
| bitwarden   | software manager     | password manager |



### Apps worth checking
| Name | Installation method | Comment |
|----------|----------|----------|
| timeshift   | comes installed with mint  | better if additional storage is available (i.e. for snapshots)|  
| localSend   | software manager     | not detecting some devices |
| syncthing   | software manager     | not launching |

