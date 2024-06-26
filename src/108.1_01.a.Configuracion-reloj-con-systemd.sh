#!/bin/bash

# Configuración de reloj

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/102-500/108/108.1/108.1_01/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
###### apt install -y 'package'

## Configuración de variables
SERVICE='systemd-timesyncd'
timestamp=$(date +%F_%H.%M.%S)
TIME_ZONE=$(timedatectl list-timezones | grep Buenos_Aires -m 1)

## Impresión de fecha y hora del sistema
echo -e "$verde Fecha y hora del sistema: $default"
timedatectl

## Respaldo de configuración
cp /etc/timezone /var/backups/timezone.$timestamp

## Modificación de configuración
echo -e "$cian Modificando configuración $default"
echo -e "$verde Con systemd $default"
echo "
##########################
### Editado por ~ferorge #
##########################
NTP=0.south-america.pool.ntp.org
" >> /etc/systemd/timesyncd.conf

systemctl daemon-reload
timedatectl set-timezone $TIME_ZONE
timedatectl set-ntp false
timedatectl set-ntp true

## Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
systemctl restart $SERVICE

## Estado de servicio
systemctl status $SERVICE

## Verificación de configuración
echo -e "$cian Verificando configuración $default"
timedatectl
