#!/usr/bin/env bash

# Esqueleto para html

## __Autoría y licencia__
###### Esqueleto para html © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(https://learning.lpi.org/es/learning-materials/102-500/107/107.1/107.1_01/)

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)
YEAR=$(date +%Y)
DATE=$(date +%F)
MD='/tmp/user_index.md'

## __Respaldo de configuración__
logger 'skel-http | Respaldando configuración.'
DIR='/etc/skel/public_html/'
FILE='index.html'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
logger 'skel-http | Modificando configuración.'
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE

# Agregar directorio y fichero a skel
mkdir -p $DIR
chmod 0755 $DIR
cat <<EOF > $MD
Language: es
Author: sobnix
Email: root@sobnix.ar
Affiliation: https://$FQDN
Date: $DATE
copyright: $YEAR, sobnix, CC BY-SA 4.0.
KeyWords: servidor, publico, libre, pubnix, auto alojado, soberano
css: lynx.css
Quotes Language: es
Base Header Level: 1
Title: Home

EOF

cowsay -f pocho 'Bienvenide a mi sitio web libre, público y soberano.' | sed 's/^/          /g' >> $MD
echo '' >> $DIR$FILE

multimarkdown --nolabels -o $DIR$FILE $MD

cp "${0%/*}"/html/{favicon.ico,lynx.css} $DIR

if [ $UID == 0 ]; then
  chown root:staff $DIR{"favicon.ico","index.html","lynx.css"}
  chmod 0664 $DIR{"favicon.ico","index.html","lynx.css"}
fi
