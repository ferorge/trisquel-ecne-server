#!/bin/bash

# Configuración de netplan

## __Autoría y licencia__
###### Configuración de netplan © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/netplan/'
FILE='01-netcfg.yaml'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
echo '
########################
# Editado por ~ferorge #
########################
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: yes
      dhcp6: no
#      addresses: [10.0.0.1/16]
#      gateway4: 10.0.0.1  ## no hace falta para miserables
#      nameservers:
#        search: [sobnix.dynv6.net]
#        addresses: [10.0.0.1, 45.71.185.100, 185.121.177.177]
  wifis:
    wlan0:
      dhcp4: yes
      dhcp6: no
      access-points:
        "LaDelPaisaTampocoEs":
          password: "contraseña"
' > $DIR$FILE

netplan apply

## __Verificacion de configuración__
echo -e "$CYAN Verificando configuración $DEFAULT"
sleep 15
ip a


