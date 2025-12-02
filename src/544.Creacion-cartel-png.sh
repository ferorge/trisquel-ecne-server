#!/usr/bin/env bash

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

cat /var/gopher/_cartel.md | convert -font Liberation-Mono-Bold -background black -fill red -extent 468x60-40+52 text:- -bordercolor white -border 2 $DIR$FILE

chown fernando:staff $DIR$FILE
chmod 0664 $DIR$FILE

## __Verificación de configuración__
echo -e "$CYAN Verificando configuración $DEFAULT"

