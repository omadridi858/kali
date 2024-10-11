#!/bin/bash

# Set password for user 'root'
echo -e "123\n123" | sudo passwd root

# Clean up previous ngrok files if they exist
rm -rf ngrok ngrok.zip ng.sh > /dev/null 2>&1

# Download and execute ngrok setup script
wget -O ng.sh https://raw.githubusercontent.com/omadridi858/kali/main/ng.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh "$1"

# Clear terminal and display ngrok region selection
clear
echo "======================="
echo "Choose ngrok region"
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"

# Start ngrok on TCP port 3388
./ngrok tcp --region us 3388 &>/dev/null &

# Install Docker image for RDP
echo "===================================="
echo "Install RDP"
echo "===================================="
docker pull danielguerra/ubuntu-xrdp

# Clear terminal and display RDP connection info
clear
echo "===================================="
echo "Start RDP"
echo "===================================="
echo "Username : ubuntu"
echo "Password : ubuntu"
echo "RDP Address:"
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'

# Keep RDP running message
echo "===================================="
echo "Don't close this tab to keep RDP running"
echo "Wait 2 minutes to finish the setup then run using RDP Address"
echo "===================================="

# Start the docker container for RDP
docker run --rm -p 3388:3389 danielguerra/ubuntu-xrdp:kali > /dev/null 2>&1
