#!/bin/bash

# Endurecimiento BOOT-5122

## __Autoría y licencia__
###### Endurecimiento BOOT-5122 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [BOOT-5122]:(https://cisofy.com/lynis/controls/BOOT-5122/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='BOOT-5122'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# PKG=''
# apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/grub.d/'
FILE='00_header'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
mkdir -p $DIR
echo -e write grub password and press Enter, twice.
pass=$(grub-mkpasswd-pbkdf2)
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
cat << EOF
set superusers=\"root\"
password_pbkdf2 root grub.$(echo $pass | cut -d \. -f 2-)
EOF
########################
" >> $DIR$FILE

## __Respaldo de configuración__
DIR='/etc/grub.d/'
FILE='10_linux'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
sed -i -e '/$title/,/${CLASS} /s/${CLASS} /${CLASS} --user \"\" /' -e '/$os/,/${CLASS} /s/${CLASS} /${CLASS} --unrestricted /' $DIR$FILE

update-grub2

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

