#!/bin/bash

# Modificación de aside

## __Autoría y licencia__
###### Modificación de aside © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
DIR='/var/gopher/'
FILE=$DIR'_aside.md'
FQDN=$(hostname -f)
DR='/var/local/ubuntu-noble-server/doc/site/'
SUB_DIR=''
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/var/gopher/'
FILE='_aside.md'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"

# Borra el contenido de _aside.mmd
echo '' > $DIR$FILE

# Recorre el document root buscando sitios y generando enlaces
SITES=$(find $DR -name "*.md" | sort)
for SITE in $SITES
do
#  NAME_SITE=$(echo $SITE | cut -d'/' -f 8 | sort)
  NAME_SITE=$(echo $SITE | cut -d'/' -f 8 | sort | cut -d '.' -f 2)
# Verifica que NAME_SITE no esté vacío
  if [ ! -z "$NAME_SITE" ]
  then
    DIR_NAME=$(echo $SITE | cut -d'/' -f 7)
    if [[ $SUB_DIR != $DIR_NAME ]]
    then
    SUB_DIR=$DIR_NAME
    echo "- ${SUB_DIR^}" >> $DIR$FILE
    fi
    LINK=$(printf "https://$FQDN/$SUB_DIR/$NAME_SITE.html")
    echo "    - [$NAME_SITE]($LINK)" >> $DIR$FILE
  fi
done

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi

