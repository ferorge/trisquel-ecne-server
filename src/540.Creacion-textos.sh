#!/bin/bash

# Creación de saludo

## __Autoría y licencia__
###### Creación de saludo © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
HOST=$(hostname -s)
timestamp=$(date +%F_%H.%M.%S)
DATE=$(date +%F)
YEAR=$(date +%Y)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/local/'
#FILE="*.md"
#cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"

DIV='_______________________________________________'

cat <<EOF > $DIR'_meta.md'
Author: ~ferorge
Date: $DATE
copyright: $YEAR, ~ferorge, CC BY-SA 4.0.
Email: ferorge@texto-plano.xyz
KeyWords: servidor, publico, libre, pubnix, auto alojado, soberano
css: lynx.css
EOF

cat <<EOF > $DIR'_saludo.md'
Bienvenide a sobnix
===================
EOF

toilet -f ivrit -k "    $HOST" > $DIR'_cartel.md'

fortune rms2 > $DIR'_motd.md'

toilet -f mini -k '  Usuaries' > $DIR'_usuaries.md'

echo "$HOST | Pubnix soberano" > $DIR'_pie.md'

cat <<EOF > /var/gopher/gophermap
$(cat $DIR'_meta.md')
title: $(head -n1 $DIR'_saludo.md')

$(cat $DIR'_saludo.md')
$DIV
$(cat $DIR'_cartel.md')
$DIV
$(cat $DIR'_motd.md' | cowsay -f tux | sed 's/^/          /g')
$DIV
$(cat $DIR'_usuaries.md')
$DIV
$(cat $DIR'_pie.md')
$DIV
EOF


#
####### Servidor + Publico | Libre > Pubnix
#
####### Pubnix | Auto alojado > Soberano
#_______________________________________________' >> $DIR$FILE

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
