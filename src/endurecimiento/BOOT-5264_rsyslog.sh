#!/bin/bash

# Endurecimiento BOOT-5264 rsyslog

## __Autoría y licencia__
###### Endurecimiento BOOT-5264 rsyslog © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
UNIT='rsyslog'
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
sed -i 's/CapabilityBoundingSet=/CapabilityBoundingSet=~CAP_MAC_* CAP_SYS_CHROOT CAP_NET_RAW CAP_NET_BROADCAST CAP_NET_BIND_SERVICE CAP_NET_ADMIN CAP_SYS_TTY_CONFIG CAP_SYS_RESOURCE CAP_SYS_NICE CAP_SYS_PACCT CAP_SYS_BOOT CAP_SYS_PTRACE CAP_SYS_RAWIO CAP_SYS_ADMIN CAP_BLOCK_SUSPEND CAP_IPC_LOCK CAP_LINUX_IMMUTABLE CAP_LEASE CAP_KILL CAP_BPF CAP_SETFCAP CAP_FSETID CAP_CHOWN CAP_IPC_OWNER CAP_FOWNER CAP_DAC_* CAP_SETPCAP CAP_SETGID CAP_SETUID CAP_AUDIT_*/g' $SERVICE
sed -i 's/PrivateNetwork=true/PrivateNetwork=false/g' $SERVICE
sed -i 's/ProcSubset=pid/ProcSubset=all/g' $SERVICE
sed -i 's/ProtectKernelLogs=true/ProtectKernelLogs=false/g' $SERVICE
sed -i 's/ProtectSystem=strict/ProtectSystem=full/g' $SERVICE
sed -i 's/RestrictAddressFamilies=/RestrictAddressFamilies=AF_UNIX AF_INET/g' $SERVICE

## __Recarga de servicio__
echo -e "$cian Recargando servicio $default"
systemctl daemon-reload

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

