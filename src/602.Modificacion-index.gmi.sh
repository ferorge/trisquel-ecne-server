#!/bin/bash

# Modificación de index.gmi

## __Autoría y licencia__
###### Modificación de index.gmi © 2024 por \~ferorge
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

## __Configuración de requisitos previos__
echo -e "$cian Configurando requisitos previos $default"
source "${0%/*}"/540.Creacion-textos.sh

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/gemini/gmi/'
FILE='index.gmi'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"

DIV='_______________________________________________'

sed 's/######/ /g' /var/gopher/_saludo.md > $DIR$FILE
cat /var/gopher/_motd.md | /usr/games/cowsay -f tux | sed 's/^/### /g'  >> $DIR$FILE
echo $DIV >> $DIR$FILE
#vrms |fold -w 64 | sed 's/^/### /g' >> $DIR$FILE
vrms |fold -w 64 >> $DIR$FILE
echo $DIV >> $DIR$FILE
echo "
En línea desde: $(uptime -s)" >> $DIR$FILE
echo $DIV >> $DIR$FILE
sed "1,4 s/^/### /g" /var/gopher/_usuaries.md >> $DIR$FILE
echo $DIV >> $DIR$FILE
echo '' >> $DIR$FILE
#sed -i "1,7 s/^/# /g" $DIR$FILE
sed -i "1 s/^/# /g" $DIR$FILE
sed -i "2 s/^/==/g" $DIR$FILE
#sed -i "8,11 s/^/###/g" $DIR$FILE
sed -i "s/$DIV/## $DIV/g" $DIR$FILE

USERS_DIR='../users/'
USERS=$(ls $DIR$USERS_DIR)

for USER in $USERS
do
  echo '=> ~'$USER$'\t''~'$USER >> $DIR$FILE
done
echo '' >> $DIR$FILE
echo 'EOF' >> $DIR$FILE

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi


