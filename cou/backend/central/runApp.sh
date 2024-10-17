#!/bin/bash
set -e  # Stop the script if any command fails
source ~/.bashrc

echo "Switch to the project folder:"
cd /home/site/wwwroot || { echo "Directory not found"; exit 1; }
echo ""

# Verify installations
echo "Check the Go version in the path:"
if ! command -v go &> /dev/null; then
    echo "Go is not installed or not in the PATH."
    exit 1
fi
go version
echo ""

echo "Check the make version in the path:"
if ! command -v make &> /dev/null; then
    echo "Make is not installed or not in the PATH."
    exit 1
fi
make --version
echo ""

echo "Switch the PORT variable to 5000"
export PORT=5000
echo ""

echo "Confirm PORT value is changed:"
echo "Current port: $PORT"
echo ""

echo "Remove the existing Go binary..."
if [ -d "bin" ]; then
    rm -r bin
    echo "Existing binary removed."
else
    echo "No binary directory found. Skipping removal."
fi
echo ""

echo "Build new binary for the Linux platform..."
if make build; then
    echo "Binary built successfully."
else
    echo "Build failed."
    exit 1
fi
echo ""

echo "Make manageApp.sh executable"
if [ -f "manageApp.sh" ]; then
    chmod +x manageApp.sh
    echo "manageApp.sh is now executable."
else
    echo "manageApp.sh not found."
    exit 1
fi
echo ""

echo "Start the Go app..."
./manageApp.sh start
echo ""

echo "Check app status"
./manageApp.sh status
echo ""
