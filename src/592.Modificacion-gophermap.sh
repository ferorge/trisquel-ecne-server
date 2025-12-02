#!/usr/bin/env bash

# Modificación de gophermap

## __Autoría y licencia__
###### Modificación de gophermap © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
FQDN=$(hostname -f)
timestamp=$(date +%F_%H.%M.%S)
DIV='_________________________________________________'

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/var/gopher/'
FILE='gophermap'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
#ls /var/local/saludo
#if [[ $? != 0 ]];then
#  source "${0%/*}"/540.Creacion-saludo.sh
#fi
#
#ls /var/local/motd
#if [[ $? != 0 ]];then
#  source "${0%/*}"/542.Creacion-mensaje-del-dia.sh
#fi
#
#ls /var/local/usuaries
#if [[ $? != 0 ]];then
#  source "${0%/*}"/544.Creacion-usuaries.sh
#fi
#
#sed 's/######/ /g' /var/local/saludo > $DIR$FILE
#cat /var/local/motd | cowsay -f tux >> $DIR$FILE
#echo '_________________________________________________
#' >> $DIR$FILE
#vrms | fold -s -w 64 >> $DIR$FILE
#echo '_________________________________________________
#' >> $DIR$FILE
#echo " En línea desde: $(uptime -s)" >> $DIR$FILE
#echo '_________________________________________________
#' >> $DIR$FILE
#cat /var/local/usuaries >> $DIR$FILE
#echo '~' >> $DIR$FILE

cat <<EOF > $DIR$FILE
=./_cartel.md
$DIV
=./_eslogan.md
$DIV
=./_motd.md
$DIV
=./_saludo.md
$DIV
=./_licencia.md
$DIV
=./_pie.md
=./_vrms.md
EOF

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
