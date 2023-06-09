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
- [ZigBee2Mqtt](https://www.zigbee2mqtt.io/)
- [Portainer](https://hub.docker.com/r/portainer/portainer)
- [Wireguard](https://hub.docker.com/r/linuxserver/wireguard)
- [DuckDNS](https://hub.docker.com/r/linuxserver/duckdns)
- [Transmission](https://hub.docker.com/r/linuxserver/transmission)
- [Plex](https://www.plex.tv/)
- Others I surely forgot to mention
