#!/bin/bash

# Crear enlaces

## __Autoría y licencia__
###### Crear enlaces © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
FQDN=$(hostname -f)
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR=''
FILE=''
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
#grep ferorge $DIR$FILE
#if [[ $? != 0 ]];then
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE
#fi

ln -s /var/local/ubuntu-noble-server/src/540.Crear-textos.sh /etc/cron.hourly/Crear-textos
