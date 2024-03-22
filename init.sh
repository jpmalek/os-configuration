#!/bin/bash
echo "**** STARTING INIT SCRIPT ****"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unattended-upgrades
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure -f noninteractive unattended-upgrades
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y && sudo apt-get upgrade -y
# capture the current directory in a variable for use in executing scripts in the same directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Anaconda takes many GB of space! So for now, commenting this out. Script is ready to go, just double-check latest version of Anaconda
# .install_anaconda.sh
. $DIR/install_standard_packages.sh
. $DIR/install_chrome.sh
. $DIR/install_awscli.sh
. $DIR/install_docker.sh