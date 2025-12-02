#!/usr/bin/env bash

# Esqueleto para gemini

## __Autoría y licencia__
###### Esqueleto para gemini © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(https://learning.lpi.org/es/learning-materials/102-500/107/107.1/107.1_01/)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/skel/public_gemini/'
FILE='.mollyhead'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE

# Agregar directorio y fichero a skel
mkdir -p $DIR
chmod 0755 $DIR
cowsay -f pocho 'Bienvenide a mi cápsula gemini libre, pública y soberana.' > $DIR$FILE
sed -i "1,4 s/^/##/g" $DIR$FILE
sed -i "5,$ s/^/#/g" $DIR$FILE
echo '' >> $DIR$FILE

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
