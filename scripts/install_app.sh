#!/bin/bash

# Stop on error
set -e

echo "--- 1. Installing Python 3.12 ---"
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install -y python3.12 python3.12-venv python3-pip libpq-dev

echo "--- 2. Setting up Virtual Environment ---"
cd /vagrant

# Create venv if it doesn't exist
if [ ! -d "venv" ]; then
    python3.12 -m venv venv
    echo "Virtual environment created."
fi

# Activate and install deps
source venv/bin/activate
pip install --upgrade pip
# Installing requirements 
pip install -r requirements.txt

echo "--- 3. Creating Service File (Safe Mode) ---"
# Delete the old file just in case
sudo rm -f /etc/systemd/system/hms.service
sudo touch /etc/systemd/system/hms.service
sudo chmod 777 /etc/systemd/system/hms.service


echo "[Unit]" > /etc/systemd/system/hms.service
echo "Description=HMS API Service" >> /etc/systemd/system/hms.service
echo "After=network.target" >> /etc/systemd/system/hms.service
echo "" >> /etc/systemd/system/hms.service
echo "[Service]" >> /etc/systemd/system/hms.service
echo "User=vagrant" >> /etc/systemd/system/hms.service
echo "WorkingDirectory=/vagrant" >> /etc/systemd/system/hms.service
echo "Environment=\"PATH=/vagrant/venv/bin\"" >> /etc/systemd/system/hms.service
echo "EnvironmentFile=/vagrant/.env.prod" >> /etc/systemd/system/hms.service
echo "ExecStart=/vagrant/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000" >> /etc/systemd/system/hms.service
echo "" >> /etc/systemd/system/hms.service
echo "[Install]" >> /etc/systemd/system/hms.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/hms.service

# Secure the file again
sudo chmod 644 /etc/systemd/system/hms.service

echo " Starting App "
sudo systemctl daemon-reload
sudo systemctl enable hms
sudo systemctl restart hms

echo " App Server Provisioned Successfully "
