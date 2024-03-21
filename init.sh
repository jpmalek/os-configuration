#!/bin/bash
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y && sudo apt-get upgrade -y
# Anaconda takes many GB of space! So for now, commenting this out. Script is ready to go, just double-check latest version of Anaconda
# .install_anaconda.sh
. install_standard_packages.sh
. install_chrome.sh
. install_awscli.sh
. install_docker.sh