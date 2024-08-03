#!/bin/bash

# Configuración de nombres

## __Autoría y licencia__
###### Configuración de nombres © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [LPI 109.2_01]:(https://learning.lpi.org/en/learning-materials/102-500/109/109.2/109.2_01/)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
HOST='sobnix.dynv6.net'

## __Respaldo de configuración__
echo -e "$cian Respaldando configuracion $default"
DIR='/etc/'
FILE='hostname'
cp $DIR$FILE /var/backups/$FILE.$timestamp
FILE='machine-info'
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuracion $default"
hostnamectl --pretty hostname "Sobnix | Pubnix soberano"
hostnamectl --transient hostname $FQDN
hostnamectl --static hostname $HOST
hostnamectl chassis server
hostnamectl deployment production
hostnamectl location "Lanús, Argentina"

## __Verificacion de configuracion__
echo -e "$cian Verificando configuracion $default"
hostnamectl status

