#!/bin/bash
echo "Preparing EC2 Ubuntu Instance"

# update ubuntu
sudo apt update
sudo apt full-upgrade -y
apt-get autoremove -y
apt-get autoclean -y

echo "***********************"
echo "Installing make and git"
echo "***********************"
sudo apt -y install git-all
sudo apt-get -y install make

echo "*****************"
echo "Installing Docker"
echo "*****************"
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo apt-get install docker-ce=5:20.10.13~3-0~ubuntu-focal docker-ce-cli=5:20.10.13~3-0~ubuntu-focal containerd.io
echo "-----------------------"
sudo docker --version
echo "-----------------------"


echo "*************************"
echo "Installing Docker Compose"
echo "*************************"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "-----------------------"
sudo docker-compose --version
echo "-----------------------"
