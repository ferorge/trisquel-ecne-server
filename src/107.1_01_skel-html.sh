#!/bin/bash

# Esqueleto para html

## __Autoría y licencia__
###### Esqueleto para html © 2024 por \~ferorge
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
MD='/tmp/user_index.md'

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/skel/public_html/'
FILE='index.html'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE

# Agregar directorio y fichero a skel
mkdir -p $DIR
chmod 0755 $DIR
cowsay -f pocho 'Bienvenide a mi sitio web libre, público y soberano.' | sed 's/^/          /g' > $MD
echo '' >> $DIR$FILE

multimarkdown --nolabels -o $DIR$FILE $MD

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
