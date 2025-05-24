#!/bin/bash

# Endurecimiento HRDN-7231

## __Autoría y licencia__
###### Endurecimiento HRDN-7231 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [HRDN-7231]:(https://cisofy.com/lynis/controls/HRDN-7231/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='HRDN-7231'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# PKG=''
# apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/modprobe.d/'
FILE='HRDN-7231.conf'
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
install binfmt_misc /bin/true
########################
" >> $DIR$FILE

mkdir -p /var/backups/usr-lib-binfmt.d/
mv /usr/lib/binfmt.d/* /var/backups/usr-lib-binfmt.d/

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

