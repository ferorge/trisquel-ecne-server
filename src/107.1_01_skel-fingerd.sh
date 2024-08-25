#!/bin/bash

# Esqueleto para finger

## __Autoría y licencia__
###### Esqueleto para finger © 2024 por \~ferorge
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
DIR='/etc/skel/'
FILE='.plan'
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### En este fichero puedes indicarle a otras personas el plan en el que  
###### trabajas o a lo que te dedicas actualmente.
###### ' >> $DIR$FILE

cowsay "Mi plan para la comunidad $FQDN" > $DIR$FILE
chmod 0644 $DIR$FILE

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/skel/'
FILE='.project'
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### En este fichero puedes indicarle a otras personas el proyecto en el que  
###### trabajas o que te gustaría participar.
###### ' >> $DIR$FILE

cowsay "Mi proyecto para la comunidad $FQDN" > $DIR$FILE
chmod 0644 $DIR$FILE

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/skel/'
FILE='.xface'
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
cowsay -W 47 -f /usr/share/cowsay/cows/eyes.cow '<>' > $DIR$FILE
chmod 0644 $DIR$FILE

touch /etc/skel/.fingerlog
