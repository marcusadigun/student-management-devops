#!/bin/bash

set -e 

echo "--- Installing PostgreSQL ---"
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# Looks into /etc/postgresql/ to see what version folder exists (e.g., 14, 15, 16)
PG_VERSION=$(ls /etc/postgresql/ | sort -V | tail -n 1)

if [ -z "$PG_VERSION" ]; then
    echo " Error: PostgreSQL installation failed. No version folder found in /etc/postgresql/"
    exit 1
fi

echo " Detected PostgreSQL Version: $PG_VERSION"

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"


# 1. Listen on all interfaces
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# 2. Allow connection from App Server (192.168.56.11)
if ! grep -q "192.168.56.11" "$PG_HBA"; then
    echo "host    all             all             192.168.56.11/32        scram-sha-256" | sudo tee -a "$PG_HBA"
fi

sudo systemctl restart postgresql

# USER CREATION
# Switch to postgres user to run SQL commands
sudo -u postgres psql -c "CREATE USER hms_user WITH PASSWORD 'securepassword';" || echo "User likely already exists"
sudo -u postgres psql -c "CREATE DATABASE hms_db OWNER hms_user;" || echo "Database likely already exists"

echo " Database Provisioned Successfully"
