#!/bin/bash

# Endurecimiento BOOT-5264 systemd-udevd

## __Autoría y licencia__
###### Endurecimiento BOOT-5264 systemd-udevd © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
UNIT='systemd-udevd'
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
sed -i 's/Type=simple/#Type=simple/g' $SERVICE
sed -i 's/Restart=always/#Restart=always/g' $SERVICE
sed -i 's/CapabilityBoundingSet=/CapabilityBoundingSet=~CAP_SYS_TIME CAP_WAKE_ALARM CAP_SYS_ADMIN CAP_SYS_PTRACE CAP_SETUID CAP_SETGID CAP_SETPCAP/g' $SERVICE
sed -i 's/# IPAddressDeny=any/IPAddressDeny=any/g' $SERVICE
sed -i 's/PrivateDevices=true/PrivateDevices=false/g' $SERVICE
sed -i 's/PrivateTmp=true/PrivateTmp=false/g' $SERVICE
sed -i 's/PrivateUsers=true/PrivateUsers=false/g' $SERVICE
# sed -i 's/ProcSubset=pid/ProcSubset=all/g' $SERVICE
sed -i 's/ProtectHome=true/ProtectHome=false/g' $SERVICE
# sed -i 's/SystemCallFilter=@system-service/SystemCallFilter=@system-service @module @raw-io bpf/g' $SERVICE

## __Recarga de servicio__
echo -e "$cian Recargando servicio $default"
systemctl daemon-reload

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

