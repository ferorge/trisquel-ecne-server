#!/usr/bin/env bash

# Configuración de nombres

## __Autoría y licencia__
###### Configuración de nombres © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [LPI 109.2_01]:(https://learning.lpi.org/en/learning-materials/102-500/109/109.2/109.2_01/)

## __Configuración de variables__
HOST=$(hostname -s)
FQDN=$(hostname -f)
CURRENT_IP=$(curl -s ifconfig.me)

## __Respaldo de configuración__
logger "109.2_01.b | Respaldando configuracion."
DIR='/etc/'
FILE='hosts'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
logger "109.2_01.b | Modificando configuracion."

sed -i "/$FQDN/d" $DIR$FILE
echo "$CURRENT_IP	$FQDN $HOST" >> $DIR$FILE

## __Verificacion de configuracion__
logger "109.2_01.b | Verificando configuracion."
read ip fqdn host <<< `grep $HOST $DIR$FILE`
logger "IP: $ip | FQDN: $fqdn"
