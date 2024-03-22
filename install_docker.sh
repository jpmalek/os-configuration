#!/bin/bash
echo "**** STARTING DOCKER SCRIPT ****"
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y && sudo apt-get upgrade -y
# Install packages to allow apt to use a repository over HTTPS
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify that you now have the key with the fingerprint 
sudo apt-key fingerprint 0EBFCD88

# Set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package index again (to include Docker's repo)
sudo apt-get update -y

# Install the latest version of Docker Engine and containerd
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify Docker Installation by running the hello-world image
sudo docker run hello-world

# Check Docker version
sudo docker --version

echo "Docker installation script has completed."