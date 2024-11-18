#!/bin/bash

# Declaración de colores

## __Autoría y licencia__
###### Declaración de colores © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/'
FILE='environment'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo '
########################
# Editado por ~ferorge #
########################
RESET="\e[0m"
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GRAY="\e[37m"
DEFAULT="\e[39m"
' >> $DIR$FILE
fi
