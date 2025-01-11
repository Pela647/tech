#### References
- How to install [QEMU/KVM](https://forums.linuxmint.com/viewtopic.php?t=428069), then restart device.
- Intall Guest agent and start
```
sudo apt install qemu-guest-agent
systemctl start qemu-guest-agent
```
- Installing Windows:
    - Download Windows 11 iso file or create installation media [here](https://www.microsoft.com/en-us/software-download/windows11)
    - Download `latest virtio-win ISO` [here](https://github.com/virtio-win/virtio-win-pkg-scripts?tab=readme-ov-file#downloads)
    - Follow installation instructions [here](https://www.youtube.com/watch?v=WmFpwpW6Xko)

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
