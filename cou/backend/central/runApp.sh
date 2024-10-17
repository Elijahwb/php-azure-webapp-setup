# Verify installations
echo "check the go version in the path"
go version
echo ""

echo "check the make version in the path"
make --version
echo ""

echo "Switch the PORT variable to 5000"
export PATH=5000
echo ""
echo "Confirm PORT value is changed"
echo $PORT
echo ""

echo "Switch to the project folder"
cd /home/site/wwwroot
echo ""

echo "Remove the existing go binary.."
rm -r bin
echo ""

echo "Build new binary for the linux platform..."
make build
echo ""
echo "Binary built successfully"
echo ""

echo "Make manageApp executable"
chmod +x manageApp.sh
echo ""

echo "Start the go app..."
./manageApp.sh start
echo ""

echo "Check app status"
./manageApp.sh status
