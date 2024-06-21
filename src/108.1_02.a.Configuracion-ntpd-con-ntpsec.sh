#!/bin/bash

# Configuración de ntpd

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
apt install -y ntpsec

## Configuración de variables
SERVICE='ntpd'
DIR='/etc/ntpsec/'
FILE='ntp.conf'
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

## Configuracion de firewall
echo -e "$cian Configurando firewall $default"
ufw allow 123/tcp comment $SERVICE

## Activación de servicio
echo -e "$cian Activando servicio $default"
systemctl enable $SERVICE

## Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
systemctl restart $SERVICE

## Verificación de servicio
echo -e "$cian Verificando servicio $default"
systemctl status $SERVICE

## Verificación de configuración
echo -e "$cian Verificando configuración $default"
ntpq -p
