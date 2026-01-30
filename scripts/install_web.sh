#!/bin/bash
set -e

echo " Installing Nginx "
sudo apt-get update
sudo apt-get install -y nginx

echo " Configuring Nginx Reverse Proxy "
# Create a new configuration file for the site
sudo tee /etc/nginx/sites-available/hms > /dev/null <<EOF
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://192.168.56.11:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

echo " Enabling the Site "
# Link the site to sites-enabled
sudo ln -sf /etc/nginx/sites-available/hms /etc/nginx/sites-enabled/

# Remove the default "Welcome to Nginx"
sudo rm -f /etc/nginx/sites-enabled/default

echo " Testing & Restarting Nginx "
# Test config for syntax errors
sudo nginx -t
# Restart service
sudo systemctl restart nginx

echo " Web Server Provisioned Successfully "
