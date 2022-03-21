# AWS Setup Ubuntu
## Update EC2 Instance: 
- `sudo apt update` Fetches the list of available updates
- `sudo apt upgrade` Installs some updates; does not remove packages
- `sudo apt full-upgrade`  Installs updates; may also remove some packages, if needed
- `sudo apt autoremove`    Removes any old packages that are no longer needed

## Git: 
`sudo apt install git-all`

## Make:
`sudo apt-get -y install make`

## Docker: 
		
https://docs.docker.com/engine/install/ubuntu/

### Command for the correct version:

`sudo apt-get install docker-ce=5:20.10.13~3-0~ubuntu-focal docker-ce-cli=5:20.10.13~3-0~ubuntu-focal containerd.io`