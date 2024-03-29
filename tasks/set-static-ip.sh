#!/bin/bash

# Network Interface Name
interface="eth0" #change me

# Static IP Address
ip_address="192.168.10.110"
netmask="24"
gateway="192.168.10.253" #change me
dns_server="8.8.8.8"

# Network interface configuration
sudo cp /etc/dhcpcd.conf /etc/dhcpcd.conf.bak
sudo tee /etc/dhcpcd.conf > /dev/null << EOL
interface $interface
static ip_address=$ip_address/$netmask
static routers=$gateway
static domain_name_servers=$dns_server
EOL

# Reboot dhcpcd service to apply changes
sudo service dhcpcd restart