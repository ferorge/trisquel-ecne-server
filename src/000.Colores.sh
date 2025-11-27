#!/bin/bash

# Declaración de colores

## __Autoría y licencia__
###### Declaración de colores © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)
DIR='/etc/'
FILE='environment'

###### Modifica el fichero si no fue modificado previamente.
grep ferorge $DIR$FILE > /dev/null

if [[ $? != 0 ]];then

    ## __Respaldo de configuración__
    logger "Respaldando configuración."
    cp $DIR$FILE /var/local/backups/$FILE.$timestamp

    ## __Modificación de configuración__
    logger "Modificando configuración."
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
