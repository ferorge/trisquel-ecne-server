#!/bin/bash

# Endurecimiento DEB-0880

## __Autoría y licencia__
###### Endurecimiento DEB-0880 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='DEB-0880'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
PKG='fail2ban'
apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/fail2ban/'
FILE='fail2ban.local'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
mkdir -p $DIR
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
[DEFAULT]
allowipv6 = auto
########################
" >> $DIR$FILE

touch $DIR/jail.local

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

