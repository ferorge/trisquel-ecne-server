#!/usr/bin/env bash

# Creacion de navbar

## __Autoría y licencia__
###### Modificación de gophermap © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
logger '594 | Respaldando configuración.'
DIR='/var/gopher/es/'
FILE='21-navbar.txt'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
logger '594 | Modificando configuración.'
files='tmp.txt'

###### Borrado de fichero
echo '' > $DIR$FILE

###### Encuentra todos los ficheros markdown y crea un fichero temporal.
find $DIR"articles/" -maxdepth 1 -name "*.md*" > $files

###### Ordena los ficheros por número.
articles=$(cat $files | rev | cut -d / -f 1 | rev | sort)

###### Crea una línea por cada fichero y lo agrega a gophermap
for file in $articles;
do
    item=0
    name=$(echo $file | cut -d '.' -f 2)
    path=$(grep $file $files | rev | cut -d '/' -f 1-3 | rev)
    echo -e "$item$name\t$path" >> $DIR$FILE
done

###### Elimina el fichero temporal
rm $files

logger "$FILE modificado por $(whoami)"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
