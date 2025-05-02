#!/bin/bash

# Endurecimiento BOOT-5264 cron

## __Autoría y licencia__
###### Endurecimiento BOOT-5264 cron © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
UNIT='cron'
SERVICE="/lib/systemd/system/$UNIT.service"
USER=''
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
cp $SERVICE /var/backups/$UNIT.service.$timestamp

## __Endurecimiento de servicio__
sed -i "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i 's/CapabilityBoundingSet=/CapabilityBoundingSet=~CAP_SYS_ADMIN CAP_SYS_PTRACE CAP_SETUID CAP_SETGID CAP_SETPCAP/g' $SERVICE
sed -i 's/RestrictAddressFamilies=/RestrictAddressFamilies=AF_NETLINK/g' $SERVICE
sed -i 's/ProtectSystem=strict/ProtectSystem=false/g' $SERVICE

## __Recarga de servicio__
echo -e "$cian Recargando servicio $default"
systemctl daemon-reload

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

