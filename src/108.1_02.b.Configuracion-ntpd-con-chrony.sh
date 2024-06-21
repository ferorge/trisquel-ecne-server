#!/bin/bash

# Configuración de ntpd

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
apt install -y chrony

## Configuración de variables
SERVICE='chrony'
DIR='/etc/'
FILE='chrony.conf'
timestamp=$(date +%F_%H.%M.%S)

## Respaldo de configuración
##### #cp $DIR$FILE /var/backups/$FILE.$timestamp

## Modificación de configuración
echo -e "$cian Modificando configuración $default"
###### echo "
##########################
### Editado por ~ferorge #
##########################
###### " >> $DIR$FILE

## Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
systemctl restart $SERVICE

## Estado de servicio
systemctl status $SERVICE

## Verificación de configuración
echo -e "$cian Verificando configuración $default"
chronyc sources
