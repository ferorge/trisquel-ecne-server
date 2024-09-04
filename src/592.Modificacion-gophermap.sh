#!/bin/bash

# Modificación de gophermap

## __Autoría y licencia__
###### Modificación de gophermap © 2024 por \~ferorge
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
DIR='/var/gopher/'
FILE='gophermap'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
ls /var/local/saludo
if [[ $? != 0 ]];then
  source "${0%/*}"/540.Creacion-saludo.sh
fi

ls /var/local/motd
if [[ $? != 0 ]];then
  source "${0%/*}"/542.Creacion-mensaje-del-dia.sh
fi

ls /var/local/usuaries
if [[ $? != 0 ]];then
  source "${0%/*}"/544.Creacion-usuaries.sh
fi

cat /var/local/saludo /var/local/motd /var/local/usuaries > $DIR$FILE
echo '~' >> $DIR$FILE

logger "Gophermap modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
