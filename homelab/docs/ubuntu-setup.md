#### Notes
- Script to install apps/tools after fresh install of ubuntu/mint ... is `../scripts/ubuntu-setup.sh`
- FUSE filesystem for Google Drive [google-drive-ocamlfuse](https://github.com/astrada/google-drive-ocamlfuse?tab=readme-ov-file#usage), needs `client-id` and `client-secret` which can be generated from `Google Drive API`, then `vi ~/.gdfuse/default/config` and replace <client-id> and <client-secret> with the actual values.

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
- Replace wilma (`lsb_release -c`) with something else which supported by hashicorp, e.g. `jammy`.  

2 - Issue: `sudo apt update` error
```
GPG error: http://repository.spotify.com stable InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY C85668DF69375001
```
Solution: Fetch and add the missing public key.
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C85668DF69375001
```

