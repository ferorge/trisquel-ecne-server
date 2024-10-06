#!/bin/bash

# Modificación de index.html

## __Autoría y licencia__
###### Modificación de index.html © 2024 por \~ferorge
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

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/www/html/'
FILE='index.html'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
ls /var/local/saludo
if [[ $? != 0 ]];then
  source "${0%/*}"/540.Creacion-saludo.sh
fi

ls /var/local/motd
if [[ $? != 0 ]];then
  source "${0%/*}"/542.Creacion-mensaje-del-dia.sh
fi

ls /var/local/usuaries
if [[ $? != 0 ]];then
  source "${0%/*}"/544.Creacion-usuaries.sh
fi

DIV='_______________________________________________'

sed 's/######/ /g' /var/local/saludo > $DIR$FILE
cat /var/local/motd | cowsay -f tux | sed 's/^/### /g'  >> $DIR$FILE
echo $DIV >> $DIR$FILE
vrms |fold -w 64 | sed 's/^/> /g' >> $DIR$FILE
echo $DIV >> $DIR$FILE
echo "
### En línea desde: $(uptime -s)" >> $DIR$FILE
echo $DIV >> $DIR$FILE
sed "1,4 s/^/### /g" /var/local/usuaries >> $DIR$FILE
#sed -i "1,6 s/^/# /g" $DIR$FILE
#sed -i "8,11 s/^/###/g" $DIR$FILE
#sed -i "s/$DIV/## $DIV/g" $DIR$FILE

multimarkdown --nolabels $DIR$FILE

#USERS_DIR='../users/'
#USERS=$(ls $DIR$USERS_DIR)
#
#for USER in $USERS
#do
#  echo '=> ~'$USER$'\t''~'$USER >> $DIR$FILE
#done
#echo '' >> $DIR$FILE

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi


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
#
