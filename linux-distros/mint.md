#### References
- How to install [QEMU/KVM](https://forums.linuxmint.com/viewtopic.php?t=428069)

#### Troubleshooting

1 - 
Issue:
```
unable to launch "cinnamon-session-cinnamon", session "cinnamon-session-cinnamon" not found, failing back to default session.
```
Solution:
- Click `Ctrl+Alt_F1`, login and run
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
