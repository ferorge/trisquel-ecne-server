#!/bin/bash

# Endurecimiento PKGS-7370

## __Autoría y licencia__
###### Endurecimiento PKGS-7370 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [PKGS-7370]:(https://cisofy.com/lynis/controls/PKGS-7370/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='PKGS-7370'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
PKG='debsums'
apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/default/'
FILE='debsums'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
mkdir -p $DIR

sed -i '/CRON_CHECK/d' /etc/default/debsums

echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
CRON_CHECK=weekly
########################
" >> $DIR$FILE

## __Activación de servicio__
# echo -e "$cian Activando servicio $default"
# systemctl enable $UNIT

## __Reinicio de servicio__
# echo -e "$cian Reiniciando servicio $default"
# systemctl restart $UNIT

## __Verificación de servicio__
# echo -e "$cian Verificando servicio $default"
# systemctl status $UNIT

## __Verificacion de configuración__
# echo -e "$cian Verificando configuración $default"

