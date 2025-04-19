#!/bin/bash

# Endurecimiento FINT-4316

## __Autoría y licencia__
###### Endurecimiento FINT-4316 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [FINT-4316]:(https://linuxconfig.org/setting-up-a-linux-intrusion-detection-system-with-aide)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='FINT-4316'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# PKG=''
# apt install -y $PKG

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

## __Creación de base de datos__
aide --config /etc/aide/aide.conf --init
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

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

