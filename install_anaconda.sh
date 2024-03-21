#!/bin/bash
sudo apt-get update -y && sudo apt-get upgrade -y
# The anaconda-navigator package is installed by default with Anaconda Distribution and includes the 
# dependency package qt. All of the dependencies for qt should also be installed by default, but installing
# the following extended dependencies might be required for certain versions of Anaconda Distribution in order to 
# use GUI (Graphical User Interface) packages with Linux:
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
# Replace <INSTALLER_VERSION> with the version of the installer file you want to download
# For example, https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
# All installers can be found at repo.anaconda.com/archive/
# curl -O https://repo.anaconda.com/archive/Anaconda3-<INSTALLER_VERSION>-Linux-x86_64.sh
anaconda_version="Anaconda3-2024.02-1-Linux-x86_64.sh"
curl -O https://repo.anaconda.com/archive/$anaconda_version
# Verify the Data Integrity of the Installer
expected_sha="c536ddb7b4ba738bddbd4e581b29308cb332fa12ae3fa2cd66814bd735dff231"
computed_sha=$(shasum -a 256 $anaconda_version | awk '{print $1}')

if [ "$expected_sha" != "$computed_sha" ]; then
    echo "SHA256 checksum does not match!"
    exit 1
fi
# Include the bash command even if you aren't using the Bash shell
# Replace ~/Downloads with the path to the installer file, if necessary
# Replace <INSTALLER_VERSION> with the version of the installer file
# For example, Anaconda3-2023.09-0-Linux-x86_64.sh
bash ~/Anaconda3-2024.02-1-Linux-x86_64.sh
source ~/.bashrc