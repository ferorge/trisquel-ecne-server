#!/bin/bash

# Configuración de reloj

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
echo -e "$amarillo Con systemd $default"
echo "
##########################
### Editado por ~ferorge #
##########################
NTP=texto-plano.xyz
" >> /etc/systemd/timesyncd.conf
timedatectl set-ntp True
timedatectl set-timezone $TIME_ZONE

## Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
systemctl restart $SERVICE

## Estado de servicio
systemctl status $SERVICE

## Verificación de configuración
echo -e "$cian Verificando configuración $default"
ls -la /etc/localtime
cat /etc/timezone
