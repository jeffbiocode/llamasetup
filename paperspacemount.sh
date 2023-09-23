#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root or use sudo."
    exit 1
fi

# Step 1: Install cifs-utils
echo "Installing cifs-utils..."
apt update
apt install -y cifs-utils

# Step 2: Create mount point
echo "Creating mount point..."
mkdir -p /mnt/paperspace_nas

# Step 3: Set up credentials
echo "Enter NAS username:"
read -r nas_username

echo "Enter NAS password:"
read -rs nas_password  # The -s flag hides password input

echo "username=$nas_username" > /root/.nascredentials
echo "password=$nas_password" >> /root/.nascredentials
chmod 600 /root/.nascredentials

# Step 4: Mount the shared drive
echo "Mounting the shared drive..."
mount -t cifs //10.59.109.2/sd38mtj8sq /mnt/paperspace_nas -o credentials=/root/.nascredentials

# Step 5: Add to fstab for auto-mounting at boot (Optional)
echo "Do you want to auto-mount the shared drive on boot? (y/n)"
read -r response
if [ "$response" = "y" ]; then
    echo "//10.59.109.2/sd38mtj8sq /mnt/paperspace_nas cifs credentials=/root/.nascredentials 0 0" >> /etc/fstab
    echo "Entry added to fstab for auto-mounting."
fi

echo "Done!"
