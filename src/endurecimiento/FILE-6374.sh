#!/bin/bash

# Endurecimiento FILE-6374

## __Autoría y licencia__
###### Endurecimiento FILE-6374 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='FILE-6374'
UNIT=''
PKG=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# apt install -y $PKG

# __Respaldo de configuración__
DIR='/etc/'
FILE='fstab'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

# __Modificacion de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
# <file system>                           <mount point>   <type>  <options>                     <dump>  <pass>
$(grep '/ ' /etc/fstab | grep remount-ro | sed 's/errors=remount-ro/defaults/g')
$(grep '/boot' /etc/fstab | grep defaults | sed 's/defaults/defaults,nodev,nosuid,noexec/g')
$(grep '/tmp' /etc/fstab | grep defaults | sed 's/defaults/defaults,nodev,nosuid,noexec/g')
$(grep '/home' /etc/fstab | grep defaults | sed 's/defaults/defaults,nodev,nosuid/g')
$(grep '/var' /etc/fstab | grep defaults | sed 's/defaults/defaults,nodev,nosuid/g')
tmpfs                                     /dev/shm        tmpfs    defaults,nodev,nosuid,noexec 0       0
udev	                                  /dev		  devtmpfs defaults,nosuid,noexec	0	0
########################
" >> $DIR$FILE

sed -i '/ .*remount-ro/d' /etc/fstab
sed -i '/boot.*defaults /d' /etc/fstab
sed -i '/tmp.*defaults /d' /etc/fstab
sed -i '/home.*defaults /d' /etc/fstab
sed -i '/var.*defaults /d' /etc/fstab

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

