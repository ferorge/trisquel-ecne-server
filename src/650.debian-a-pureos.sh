#!/bin/bash

# debian a pureOS

## __Autoría y licencia__
###### debian a pureOS © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
echo -e "$CYAN Instalando paquetes $DEFAULT"
apt update
apt install -y wget
cd /tmp
wget https://repo.pureos.net/pureos/pool/main/p/pureos-archive-keyring/pureos-archive-keyring_2024.04.0_all.deb
dpkg --install /tmp/pureos-archive-keyring_2024.04.0_all.deb 

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/apt/'
FILE='sources.list'
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
grep ferorge $DIR$FILE > /dev/null
if [[ $? != 0 ]];then
###### echo '
########################
# Editado por ~ferorge #
########################
######

## debian10 buster | pureOS 9 amber
#deb https://repo.pureos.net/pureos amber main

## debian11 bullseye | pureOS 10 byzantium
#deb https://repo.pureos.net/pureos byzantium main

## debian12 bookworm | pureOS 11 crimson
#deb https://repo.pureos.net/pureos crimson main

## debian testing | debian landing
deb https://repo.pureos.net/pureos landing main
#deb http://deb.debian.org/debian/ testing main
#deb http://deb.debian.org/debian/ trixie main

#deb https://repo.pureos.net/pureos octarine main
#deb https://repo.pureos.net/pureos dawn main
' > $DIR$FILE
fi

apt update && apt upgrade && apt full-upgrade && apt dist-upgrade && apt clean && apt autoclean && apt autoremove
