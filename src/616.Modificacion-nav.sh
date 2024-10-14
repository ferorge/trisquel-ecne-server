#!/bin/bash

# Modificación de nav

## __Autoría y licencia__
###### Modificación de nav © 2024 por \~ferorge
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
DR='/var/www/html/public/'
SUB_DIR=''
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/gopher/'
FILE='_nav.md'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"

# Borra el contenido de _nav.md
echo '' > $DIR$FILE

# Recorre el document root buscando sitios y generando enlaces
SITES=$(find $DR -name "*.html" | sort ) #| grep -v -e index -e users)
for SITE in $SITES
do
  NAME_SITE=$(echo $SITE | cut -d'/' -f 6 | grep html | cut -d '.' -f 1)
# Verifica que NAME_SITE no esté vacío
  if [ ! -z "$NAME_SITE" ]
  then
    LINK=$(echo $SITE | sed "s/\/var\/www\/html\/public\//https:\/\/$FQDN\//" )
    echo "- [${NAME_SITE^}]($LINK)" >> $DIR$FILE
  fi
done

sed -i "s/Index/Inicio/g" $DIR$FILE

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi

