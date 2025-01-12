#### Notes
- Script to install apps/tools after fresh install of ubuntu/mint ... is `../scripts/ubuntu-setup.sh`

#### Troubleshooting
1 - Issue: `sudo apt update` error
```
The repository 'https://apt.releases.hashicorp.com wilma Release' does not have a Release file.
```
Solution:
```
$ cat /etc/apt/sources.list.d/hashicorp.list
deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg]     https://apt.releases.hashicorp.com wilma main
```
- Replace wilma (`lsb_release -c`) with something else which supported by hashicorp, e.g. `jammy`
2 - 

