# IaC_homelab

## Main Goal

Configuring new servers and services manually is a repetitive boring task.
Automation and Infrastructure as Code are the key for saving time and energy.

This is Ansible playbook that sets up an Ubuntu-based server for home projects and for running home lab services.

It also provides a series of bash scripts used to properly configure SSH access and add reasonable security before using ansible playbook tasks.

The playbook is mostly being developed for personal use and for nerdy home projects, so stuff is going to be constantly changing and breaking. Use at your own risk.

## Technologies included:

- Ansible
- Docker
- Bash Scripting

## Services included:

- [Docker](https://www.docker.com/)
- [Home Assistant](https://hub.docker.com/r/homeassistant/home-assistant)
- [Zigbee2Mqtt](https://www.zigbee2mqtt.io/)
- [Portainer](https://hub.docker.com/r/portainer/portainer)
- [Wireguard](https://hub.docker.com/r/linuxserver/wireguard)
- [DuckDNS](https://hub.docker.com/r/linuxserver/duckdns)
- [Transmission](https://hub.docker.com/r/linuxserver/transmission)
- [Plex](https://www.plex.tv/)
- Dockerized script to turn the NAS ON and OFF

## Bash scripts

Once the server is up and running for the first time, launch the bash scripts inside the 'tasks' folder to setup ssh keys and set static ip address.

## SSH

```
ssh-keygen -t rsa -b 4096
./set-ssh-config.sh
```

Use this script to copy over your previously generated RSA keys and to transfer a new sshd_config file which will be used to strengthen your SSH security.

## Static Local IP

```
./set-static-ip.sh
```

Launch this bash script inside the server to set static ip address.

## Flash Zigbee Dongle

First thing first before launching all the services, flash your Zigbee dongle with the latest Z-stack firmware from Texas Instruments (in my case SONOFF Zigbee 3.0 USB Dongle Plus (based on CC2652P).

To achieve this, you can take advantage of 2 repositories on GitHub: [Koenkk Z-Stack-firmware](https://github.com/Koenkk/Z-Stack-firmware) and [ti-cc-tool](https://github.com/git-developer/ti-cc-tool).
In a nutshell, just attach the dongle, pull and launch docker image by typing the updated firmware URL. That's it.

An example of the docker run script and links to the repo to get the latest firmware can be found on files/firmware_flash.txt

## Ansible scripts

- Change hosts.ini file to setup your Raspberry Pi host.
- Change rpi.yml variables based on your Raspberry Pi linux main user
- Change docker-compose-rpi.yml volumes to properly setup your paths and linux user. It is recommended to use a _single source of truth_ regarding volumes.
  This way, inside a single folder you can have access to all your docker services configurations (and maybe backup them once in a while because you never know..)

There are two Playbooks, one is for Raspberry Pi services, the other one is for Plex services. Playbooks have been split in two parts in order to run media services in a different (maybe more powerful) home server and let the Raspberry Pi handle the other services.

Here is an example on how to run Raspberry Pi Ansible Playbook:
```
ansible-playbook -i hosts.ini playbook-rpi.yml
```

### Services config files

Inside the _files_ folder you can find zigbee2mqtt and mosquitto basic configurations. The ansible script transfer them on the remote Raspberry before launching the docker-compose script. This way, you can avoid setting up all the configs from scratch.

Note: in order to secure up MQTT instance, it is recommended to create a hashed password file. To achieve that, simply _docker exec_ inside the mosquitto container, and launch the following script:

```
mosquitto_passwd -c <password file> <username>
```

## Turn on NAS
This script is responsible for turning on and off your remote NAS server (maybe within your local network). 
It is a pretty simple script that exposes two RESTFull APIs: /turnon and /turnoff.
The script sources (as well as the "id_rsa" private key to access the NAS server) will be copied over. Do not forget to copy your "id_rsa" key on the following path:

```
files/turn-on-nas/routes/
```

Ansible will take care of building the image (based on the Dockerfile provided) and run it.
As well as the other services, also the "turn-on-nas" should show up on the containers list.
With these APIs exposed, you can choose the client that best fits your needs.
Examples:

- Integrate the turn on / turn off trigger with Home Assistant Button
- Create an IFTTT Applet and integrate it with Alexa routines.

Both the tasks are easy to get up and running. Just do not forget to create a NAT rule on your firewall and take advantage of DuckDNS container to have updated IP of your homelab.

_Enjoy! :)_
