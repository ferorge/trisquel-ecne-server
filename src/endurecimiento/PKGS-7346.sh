#!/bin/bash

# Endurecimiento PKGS-7346

## __Autoría y licencia__
###### Endurecimiento PKGS-7346 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [PKGS-7346]:(https://cisofy.com/lynis/controls/PKGS-7346/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='PKGS-7346'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# PKG=''
# apt install -y $PKG
apt -y purge `dpkg --list | grep ^rc | awk '{ print $2; }'`

## __Respaldo de configuración__
# DIR=''
# FILE=''
# echo -e "$cian Respaldando $DIR$FILE $default"
# cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
# echo -e "$cian Modificando $DIR$FILE $default"
# mkdir -p $DIR
# echo "
# ########################
# # Editado por ~ferorge #
# ########################
# #
# # $TEST
# #
# ########################
# " >> $DIR$FILE

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

