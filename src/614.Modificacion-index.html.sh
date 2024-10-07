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

## __Generación de requisitos previos__
echo -e "$cian Generando requisitos previos $default"
ls /var/local/saludo > /dev/null
if [[ $? != 0 ]];then
  source "${0%/*}"/540.Creacion-saludo.sh
fi

ls /var/local/motd > /dev/null
if [[ $? != 0 ]];then
  source "${0%/*}"/542.Creacion-mensaje-del-dia.sh
fi

ls /var/local/usuaries > /dev/null
if [[ $? != 0 ]];then
  source "${0%/*}"/544.Creacion-usuaries.sh
fi

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/www/html/public/'
FILE='index.html'
MD='/tmp/index.md'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
DIV='_______________________________________________'

sed 's/###### /##### __/g' /var/local/saludo > $MD
sed -i "1,6 s/^/      /g" $MD
sed -i "9 s/$/__/g ; 11 s/$/__/g" $MD
cat /var/local/motd | cowsay -f tux | sed 's/^/          /g'  >> $MD
echo $DIV >> $MD
vrms |fold -w 64 | sed "2,$ s/^/>  /g" >> $MD
echo $DIV >> $MD
echo "
##### __En línea desde: $(uptime -s)__" >> $MD
echo $DIV >> $MD
sed 's/^/      /g' /var/local/usuaries >> $MD
echo $DIV >> $MD

USERS=$(grep :100: /etc/passwd | grep -v systemd | cut -d : -f 1)

for USER in $USERS
do
  echo "[~$USER](https://sobnix.dynv6.net/~$USER)  " >> $MD
done
echo '' >> $MD
echo $DIV >> $MD

multimarkdown --nolabels -o $DIR$FILE $MD

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
