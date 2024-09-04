#!/bin/bash

# Actualizar zona dynv6

## __Autoría y licencia__
###### Configuración de nombres © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### []:()

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
HOST=$(hostname)
FQDN=$(hostname -f)
CURRENT_IP=$(curl -s ifconfig.me)
UPDATE=$(curl -s "http://ipv4.dynv6.com/api/update?zone=$FQDN&ipv4=auto&token=$TOKEN")

## __Respaldo de configuración__
echo -e "$cian Respaldando configuracion $default"
DIR=''
FILE=''
#cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuracion $default"

## __Verificacion de configuración__
echo -e "$cian Verificando configuracion $default"

logger $UPDATE
logger $HOST $FQDN $CURRENT_IP $ZONE_IP $UPDATE
