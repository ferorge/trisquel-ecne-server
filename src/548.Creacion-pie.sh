#!/bin/bash

# Creación de pie

## __Autoría y licencia__
###### Creación de pie © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
HOST=$(hostname -s)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/local/'
FILE='pie'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"

echo "
_________________________________________________

$HOST | Pubnix soberano" > $DIR$FILE

logger "Pie modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
