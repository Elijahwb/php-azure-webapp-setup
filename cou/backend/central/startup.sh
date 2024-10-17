#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

apt-get update
apt-get install -y coreutils

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Removing existing Go installation..."
if command_exists go; then
    rm -rf $(go env GOROOT)
    rm -f $(which go)
fi
echo ""

echo "Installing Go 1.23.0..."
wget https://golang.org/dl/go1.23.0.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
rm go1.23.0.linux-amd64.tar.gz
echo ""

# Add Go to PATH
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
echo ""

echo "Installing make..."
if ! command_exists make; then
    apt-get update
    apt-get install -y make
else
    echo "make is already installed."
fi
echo ""
echo "Installation complete. Please restart your shell or run 'source ~/.bashrc' to update your PATH."
echo ""
echo "Installing PostgreSQL client..."
apt install postgresql-client -y
echo ""
echo "PostgreSQL client installed."
echo ""

echo "Restarting shell..."
source ~/.bashrc

# Verify installations
go version
make --version
