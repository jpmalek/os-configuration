#!/bin/bash
echo "**** STARTING STANDARD PACKAGES SCRIPT ****"
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y unzip \
    curl\
    python3 \
    python3-pip \
    python3-dev \
    unzip \
    vim \
    git \
    wget \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libpango-1.0-0 \
    libu2f-udev \
    libvulkan1 \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    openssh-client 

# Upgrade pip
sudo python3 -m pip install --upgrade pip
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
sudo pip3 install --no-cache-dir -r $DIR/requirements.txt