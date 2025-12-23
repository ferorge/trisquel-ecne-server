#!/usr/bin/env bash

# ubuntu a trisquel

## __Autoría y licencia__
###### ubuntu a trisquel © 2025 por \~ferorge
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
wget https://archive.trisquel.org/trisquel/pool/main/t/trisquel-keyring/trisquel-keyring_2023.02.07_all.deb 
dpkg --install /tmp/trisquel-keyring_2023.02.07_all.deb

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/apt/'
FILE='sources.list'
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
grep ferorge $DIR$FILE > /dev/null
if [[ $? != 0 ]];then
echo '
########################
# Editado por ~ferorge #
########################

## ubuntu 24.04 noble | trisquel 12 ecne
deb https://archive.trisquel.org/trisquel ecne main
#deb-src http://archive.trisquel.org/trisquel ecne main

deb https://archive.trisquel.org/trisquel/ ecne-updates main
#deb-src https://archive.trisquel.org/trisquel/ ecne-updates main

deb https://archive.trisquel.org/trisquel/ ecne-backports main
#deb-src https://archive.trisquel.org/trisquel/ ecne-backports main

deb https://archive.trisquel.org/trisquel/ ecne-security main
#deb-src https://archive.trisquel.org/trisquel/ ecne-security main
' > $DIR$FILE
fi

apt update && apt upgrade && apt full-upgrade && apt dist-upgrade && apt clean && apt autoclean && apt autoremove

echo 'Trisquel12' > /etc/hostname

