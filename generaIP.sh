#!/bin/bash
#
# Creates a backup
sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bk_`date +%Y%m%d%H%M`
# Changes dhcp from 'yes' to 'no'
sed -i "s/dhcp4: yes/dhcp4: no/g" /etc/netplan/00-installer-config.yaml
# Retrieves the NIC information

# Ask for input on network configuration
read -p "Introduce tu direccion ip estatica: " staticip
read -p "Introduce la IP de tu gateway: " gatewayip
echo
cat > /etc/netplan/00-installer-config.yaml <<EOF
network:
    version: 2
    ethernets:
      enp0s8:
        addresses: [$staticip/24]
        gateway4: $gatewayip
        nameservers:
            addresses: [8.8.8.8,8.8.4.4]
      enp0s3:
        addresses: [192.168.100.1/24]
        dhcp4: no
        nameservers:
            addresses: [8.8.8.8,8.8.4.4]
            search: []
        optional: true
EOF
sudo netplan apply
echo "==========================="
echo

















^G Get Help      ^O Write Out     ^W Where Is      ^K Cut Text      ^J Justify       ^C Cur Pos       M-U Undo         M-A Mark Text    M-] To Bracket   M-Q Previous     ^B Back
^X Exit          ^R Read File     ^\ Replace       ^U Paste Text    ^T To Spell      ^_ Go To Line    M-E Redo         M-6 Copy Text    ^Q Where Was     M-W Next         ^F Forward
