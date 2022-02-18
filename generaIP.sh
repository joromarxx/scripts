#!/bin/bash
#
# Creamos una copia
sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bk_`date +%Y%m%d%H%M`
# Cambia dhcp from 'yes' to 'no'
sed -i "s/dhcp4: yes/dhcp4: no/g" /etc/netplan/00-installer-config.yaml

# Nos pregunta por la configuración
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
