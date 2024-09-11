#!/bin/bash

# Creación de metadatos multimarkdown

## __Autoría y licencia__
###### Creación de metadatos multimarkdown © 2024 por \~ferorge
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
DATE=$(date +%F)
YEAR=$(date +%Y)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/gopher/'
FILE='_meta.mmd'
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
echo "\
Author: ~ferorge
Date: $DATE
copyright: $YEAR, ~ferorge, CC BY-SA 4.0.
Email: ferorge@texto-plano.xyz
KeyWords: servidor, publico, libre, pubnix, auto alojado, soberano
css: lynx.css
" > $DIR$FILE
