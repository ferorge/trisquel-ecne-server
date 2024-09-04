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
apt install -y util-linux-extra

## Configuración de variables
SERVICE=''
timestamp=$(date +%F_%H.%M.%S)
TIME_LOCAL=$(date)
TIME_UTC=$(date -u)
TIME_RTC=$(hwclock)
TIME_DIF=$(hwclock --verbose | grep drift)
TIME_ZONE=$(find /usr/share/zoneinfo/ -name Buenos_Aires)

## Impresión de TIME local y UTC
echo -e "$verde Hora local: $rojo $TIME_LOCAL $default"
echo -e "$verde Hora   UTC: $rojo $TIME_UTC   $default"

## Impresión de TIME del sistema
echo -e "$verde Hora hardware: $rojo $TIME_RTC $default"
echo -e "$verde Diferencia entre Hora local y Hora de hardware (RTC): $default"
echo -e "$rojo $TIME_DIF $default"

## Respaldo de configuración
cp /etc/timezone /var/local/backups/timezone.$timestamp

## Modificación de configuración
echo -e "$cian Modificando configuración $default"

echo -e "$amarillo Sin systemd $default"
###### date +%Y%m%d -s "20240615"
ln -s $TIME_ZONE /etc/localtime
hwclock --systohc
###### systohc: SYStem TO Hardware Clock
echo $TIME_ZONE | cut -d / -f 5-7 > /etc/timezone

## Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
###### systemctl restart $SERVICE

## Estado de servicio
###### systemctl status $SERVICE

## Verificación de configuración
echo -e "$cian Verificando configuración $default"
ls -la /etc/localtime
cat /etc/timezone
