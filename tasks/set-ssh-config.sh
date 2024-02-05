#!/bin/bash

remote_user="pi" # example remote user
remote_host="192.168.10.178" # example remote host
rsa_key_path="$(realpath ~/.ssh/id_rsa.pub)"
sshd_config_path="/etc/ssh"
remote_home_dir="/home/$remote_user"

script_directory="$(dirname "$0")"
new_sshd_config="sshd_config"
new_sshd_config_path="$script_directory/$new_sshd_config"

# Copy RSA key on remote server
ssh-copy-id -i "$rsa_key_path" "$remote_user@$remote_host"

# Copy hardened sshd_config file on remote server home directory
scp "$new_sshd_config_path" "$remote_user@$remote_host:$remote_home_dir"

# Move sshd_config file from home directory to SSH config dir and reboot SSH service
ssh "$remote_user@$remote_host" "sudo -S mv $new_sshd_config $sshd_config_path && sudo -S service ssh restart"
