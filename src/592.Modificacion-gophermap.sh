#!/usr/bin/env bash

# Modificación de gophermap

## __Autoría y licencia__
###### Modificación de gophermap © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Creacion de textos__
source "${0%/*}"/540.Creacion-textos.sh

## __Creacion de navbar__
source "${0%/*}"/594.Creacion-navbar.sh

## __Creacion de navbar__
source "${0%/*}"/596.Creacion-menu.sh

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)
DIV='  ______ ______ ______ ______ ______ ______ ______ ______ ______'

## __Respaldo de configuración__
logger '592 | Respaldando configuración.'
DIR='/var/gopher/'
FILE='gophermap'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
logger '592 | Modificando configuración.'

cat <<EOF > $DIR$FILE
=es/12-cartel.md
$DIV
=es/13-eslogan.md
$DIV
=es/21-navbar.txt
$DIV
=es/31-menu.txt
$DIV

$(fold -s -w 63 es/61-motd.md)
$DIV
=es/62-usuaries.md
$DIV

~
$DIV
=es/72-pie.md
=es/73-vrms.md
EOF

# $DIV
# $(sed s/Documento/gophermap/g es/71-licencia.md)

logger "$FILE modificado por $(whoami)"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
