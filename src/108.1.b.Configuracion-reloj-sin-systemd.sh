#!/bin/bash

# Configuración de reloj

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
apt install -y util-linux-extra

## Configuración de variables
SERVICE='systemd-timesyncd'
timestamp=$(date +%F_%H.%M.%S)
TIME_LOCAL=$(date)
TIME_UTC=$(date -u)
TIME_RTC=$(hwclock)
TIME_DIF=$(hwclock --verbose | grep drift)
TIME_ZONE=$(timedatectl list-timezones | grep Buenos_Aires -m 1)

## Impresión de TIME local y UTC
echo -e "$verde TIME local: $rojo $TIME_LOCAL $default"
echo -e "$verde TIME   UTC: $rojo $TIME_UTC   $default"

## Impresión de TIME del sistema
echo -e "$verde TIME hardware: $rojo $TIME_RTC $default"
echo -e "$verde Diferencia entre TIME local y TIME de hardware (RTC): $default"
echo -e "$rojo $TIME_DIF $default"
timedatectl

## Respaldo de configuración
cp /etc/timezone /var/backups/timezone.$timestamp

## Modificación de configuración
echo -e "$cian Modificando configuración $default"

echo -e "$amarillo Sin systemd $default"
###### date +%Y%m%d -s "20240615"
ln -s /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
hwclock --systohc
echo $TIME_ZONE > /etc/timezone

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
