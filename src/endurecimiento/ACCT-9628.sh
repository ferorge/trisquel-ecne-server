#!/bin/bash

# Endurecimiento ACCT-9628

## __Autoría y licencia__
###### Endurecimiento ACCT-9628 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [ACCT-9628]:(https://linux-audit.com/monitoring-linux-file-access-changes-and-modifications/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='ACCT-9628'
UNIT='auditd'
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
PKG='auditd audispd-plugins'
apt install -y $PKG

## __Respaldo de configuración__
# DIR='/etc/audit/audit.d/'
# FILE='audit.rules'
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
# sed -i 's/^[^#]*32bit_api/#&/' $DIR$FILE

## __Activación de servicio__
echo -e "$cian Activando servicio $default"
systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

## __Verificacion de configuración__
# echo -e "$cian Verificando configuración $default"

