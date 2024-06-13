#!/bin/bash

# Configuración de reloj

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
apt install -y util-linux-extra

## Configuración de variables
SERVICIO=''
timestamp=$(date +%F_%H.%M.%S)
HORA_LOCAL=$(date)
HORA_UTC=$(date -u)
HORA_RTC=$(hwclock)
HORA_DIF=$(hwclock --verbose | grep drift)

## Impresión de hora local y UTC
echo -e "$verde Hora local: $rojo $HORA_LOCAL $default"
echo -e "$verde Hora   UTC: $rojo $HORA_UTC   $default"

## Impresión de hora del sistema
echo -e "$verde Hora hardware: $rojo $HORA_RTC $default"
echo -e "$verde Diferencia entre hora local y hora de hardware (RTC): $default"
echo -e "$rojo $HORA_DIF $default"
timedatectl

## Respaldo de configuración
#cp /etc/timezone /var/backups/timezone.$timestamp

## Modificación de configuración
#echo -e "$cian Modificando configuración $default"
#echo "NTP=texto-plano.xyz" >> /etc/systemd/timesyncd.conf
#timedatectl set-ntp True
#timedatectl set-timezone 'America/Argentina/Buenos_Aires'

## Reinicio de servicio
#echo -e "$cian Reiniciando servicio $default"
#systemctl restart systemd-timesyncd

## Estado de servicio
systemctl status systemd-timesyncd
