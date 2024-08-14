#!/bin/bash

# Título

## __Autoría y licencia__
###### Título © 2024 por \~ferorge
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
###### cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### En este fichero puedes indicarle a otras personas el plan en el que  
###### trabajas o a lo que te dedicas actualmente.
###### ' >> $DIR$FILE

cowsay 'Estoy trabajando en un nuevo plan.' > /etc/skel/.plan

#greeting='# Te damos la bienvenida a nuestro servidor tilde de uso compartido.'
#project="# En este fichero puedes indicarle a otras personas el o los proyectos en los que trabajas actualmente."
#echo -e $"$greeting\n$plan\n" > /etc/skel/.plan
#echo -e $"$greeting\n$project\n" > /etc/skel/.project

cowthink 'Estoy trabajando en un nuevo proyecto.' > /etc/skel/.project
touch /etc/skel/.fingerlog
