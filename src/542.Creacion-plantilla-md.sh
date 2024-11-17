#!/bin/bash

# Creación de textos

## __Autoría y licencia__
###### Creación de textos © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Generación de requisitos previos__
source "${0%/*}"/540.Creacion-textos.sh

## __Configuración de variables__
HOST=$(hostname -s)
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/gopher/'
FILE="_plantilla.md"
#cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"

DIV='_______________________________________________'

cat <<EOF > $DIR$FILE
$(cat $DIR'_meta.md')
Title: Plantilla

$DIV

Nuevo artículo en $HOST.
$DIV

$(cat $DIR'_licencia.md')
$(echo EOF)
EOF

sed -i 's/Documento/Plantilla/g' $DIR$FILE

logger "$FILE modificados por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi

