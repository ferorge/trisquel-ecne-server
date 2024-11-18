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
echo -e "$CYAN Instalando paquetes $DEFAULT"
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
echo -e "$GREEN Hora local: $RED $TIME_LOCAL $DEFAULT"
echo -e "$GREEN Hora   UTC: $RED $TIME_UTC   $DEFAULT"

## Impresión de TIME del sistema
echo -e "$GREEN Hora hardware: $RED $TIME_RTC $DEFAULT"
echo -e "$GREEN Diferencia entre Hora local y Hora de hardware (RTC): $DEFAULT"
echo -e "$RED $TIME_DIF $DEFAULT"

## Respaldo de configuración
cp /etc/timezone /var/local/backups/timezone.$timestamp

## Modificación de configuración
echo -e "$CYAN Modificando configuración $DEFAULT"

echo -e "$YELLOW Sin systemd $DEFAULT"
###### date +%Y%m%d -s "20240615"
ln -s $TIME_ZONE /etc/localtime
hwclock --systohc
###### systohc: SYStem TO Hardware Clock
echo $TIME_ZONE | cut -d / -f 5-7 > /etc/timezone

## Reinicio de servicio
echo -e "$CYAN Reiniciando servicio $DEFAULT"
###### systemctl restart $SERVICE

## Estado de servicio
###### systemctl status $SERVICE

## Verificación de configuración
echo -e "$CYAN Verificando configuración $DEFAULT"
ls -la /etc/localtime
cat /etc/timezone
