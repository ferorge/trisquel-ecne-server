#!/bin/bash

# Creación del mensaje del día

## __Autoría y licencia__
###### Creación del mensaje del día © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/local/'
FILE='motd.md'
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"

MSG=$(fortune rms2 | fold -s -w 80)
echo "
> $MSG

-------------------------------------------------------------------------------
" > $DIR$FILE

logger 'motd was made'

chmod 0664 $DIR$FILE

## __Verificacion de configuración__
echo -e "$cian Verificando configuración $default"
