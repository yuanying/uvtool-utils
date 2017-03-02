#!/bin/bash

hostname=${1:-"openstack.local"}
username=${2:-"yuanying"}
ip=${3:-"192.168.203.11"}
netmask=${4:-"255.255.0.0"}
gateway=${5:-"192.168.11.1"}
dns=${6:-"8.8.8.8"}

public_key=`cat ~/.ssh/id_rsa.pub`

cat <<EOS
#cloud-config
hostname: ${hostname}
users:
  - default
  - name: ${username}
    sudo: "ALL=(ALL) NOPASSWD:ALL"
    shell: "/bin/bash"
    ssh-authorized-keys:
      - "${public_key}"

runcmd:
  - [ rm, -f, /etc/network/interfaces.d/ens3.cfg]
  - [ sh, -c, "echo 'auto ens3' >> /etc/network/interfaces.d/ens3.cfg "]
  - [ sh, -c, "echo 'iface ens3 inet static' >> /etc/network/interfaces.d/ens3.cfg" ]
  - [ sh, -c, "echo '  address ${ip}' >> /etc/network/interfaces.d/ens3.cfg" ]
  - [ sh, -c, "echo '  netmask ${netmask}' >> /etc/network/interfaces.d/ens3.cfg" ]
  - [ sh, -c, "echo '  gateway ${gateway}' >> /etc/network/interfaces.d/ens3.cfg"]
  - [ sh, -c, "echo '  dns-nameservers ${dns}' >> /etc/network/interfaces.d/ens3.cfg"]
  - [ ifdown, ens3 ]
  - [ ifup, ens3 ]

EOS
