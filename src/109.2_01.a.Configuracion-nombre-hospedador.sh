#!/usr/bin/env bash

# Configuración de nombres

## __Autoría y licencia__
###### Configuración de nombres © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [LPI 109.2_01]:(https://learning.lpi.org/en/learning-materials/102-500/109/109.2/109.2_01/)

## __Configuración de variables__
HOST='sobnix.ar'

## __Respaldo de configuración__
logger "109.2_01.a | Respaldando configuracion."
DIR='/etc/'
FILE='hostname'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp
FILE='machine-info'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
logger "109.2_01.a | Modificando configuracion."
hostnamectl --pretty hostname "Sobnix | Pubnix soberano"
# hostnamectl --transient hostname $FQDN
hostnamectl --static hostname $HOST
hostnamectl chassis server
hostnamectl deployment production
hostnamectl location "Lanús, Argentina"

## __Verificacion de configuracion__
logger "109.2_01.a |  Verificando configuracion."
# hostnamectl status
logger "hostname: $(hostname -s)"
