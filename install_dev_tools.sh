#!/bin/bash

set -e

echo "Updating package list..."
sudo apt update

# -----------------------------
# Install Docker
# -----------------------------
if command -v docker &> /dev/null
then
    echo "Docker is already installed."
else
    echo "Installing Docker..."

    sudo apt install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo mkdir -p /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) \
      signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update

    sudo apt install -y docker-ce docker-ce-cli containerd.io

    echo "Docker installed successfully."
fi

# -----------------------------
# Install Docker Compose
# -----------------------------
if docker compose version &> /dev/null
then
    echo "Docker Compose is already installed."
else
    echo "Installing Docker Compose..."

    sudo apt install -y docker-compose-plugin

    echo "Docker Compose installed successfully."
fi

# -----------------------------
# Install Python
# -----------------------------
if command -v python3 &> /dev/null
then
    PYTHON_VERSION=$(python3 --version | awk '{print $2}')
    echo "Python is already installed. Version: $PYTHON_VERSION"
else
    echo "Installing Python..."

    sudo apt install -y python3 python3-pip

    echo "Python installed successfully."
fi

# -----------------------------
# Install Django
# -----------------------------
if python3 -m django --version &> /dev/null
then
    DJANGO_VERSION=$(python3 -m django --version)
    echo "Django is already installed. Version: $DJANGO_VERSION"
else
    echo "Installing Django..."

    pip3 install django

    echo "Django installed successfully."
fi

echo "All tools are installed successfully!"