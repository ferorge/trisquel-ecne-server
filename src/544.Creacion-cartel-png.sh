#!/bin/bash

# Creación de cartel.png

## __Autoría y licencia__
###### Creación de cartel.png © 2024 por \~ferorge
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
DIR='/var/www/html/public/'
FILE='banner.png'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"

cat <<EOF | convert -font Liberation-Mono-Bold -density 72 -pointsize 12 -background black -fill green -page 5x7+10 -rotate "-90>" text:- -bordercolor white -border 4 $DIR$FILE


$(cat /var/gopher/_cartel.md)
_________________________________________________
$(cat /var/gopher/_eslogan.md)
_________________________________________________
EOF

chown fernando:staff $DIR$FILE
chmod 0664 $DIR$FILE

## __Verificación de configuración__
echo -e "$CYAN Verificando configuración $DEFAULT"

