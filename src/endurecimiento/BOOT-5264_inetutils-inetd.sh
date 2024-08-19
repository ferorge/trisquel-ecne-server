#!/bin/bash

# Endurecimiento BOOT-5264 inetd

## __Autoría y licencia__
###### Endurecimiento BOOT-5264 inetd © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
UNIT='inetutils-inetd'
SERVICE="/lib/systemd/system/$UNIT.service"
USER='inetd'
VAR_DIR='/var/log/'
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
cp $SERVICE /var/backups/$UNIT.service.$timestamp

## __Endurecimiento de servicio__
grep Endurecido $SERVICE
if [[ $? != 0 ]];then
  sed -i "/\[Service\]/r ${0%/*}/../00.plantilla-de-servicios-systemd.txt" $SERVICE
  ###### sed -i "s/__USER__/$USER/g" $SERVICE
  ###### sed -i "s/__GROUP__/$USER/g" $SERVICE
  ###### sed -i -r "s#__RUN__#$RUN#g" $SERVICE
  sed -i "s#__PATH__#$VAR_DIR#g" $SERVICE
  sed -i 's/CapabilityBoundingSet=/CapabilityBoundingSet=~CAP_AUDIT_* CAP_FOWNER CAP_IPC_OWNER CAP_DAC_* CAP_BPF CAP_KILL CAP_FSETID CAP_SETFCAP CAP_LEASE CAP_LINUX_IMMUTABLE CAP_IPC_LOCK CAP_BLOCK_SUSPEND CAP_SYS_ADMIN CAP_SYS_RAWIO CAP_SYS_PTRACE CAP_SYS_BOOT CAP_SYS_PACCT CAP_SYS_NICE CAP_SYS_RESOURCE CAP_SYS_TTY_CONFIG CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_BROADCAST CAP_NET_RAW CAP_SETPCAP/g' $SERVICE
  sed -i 's/PrivateNetwork=true/PrivateNetwork=false/g' $SERVICE
  sed -i 's/PrivateUsers=true/PrivateUsers=false/g' $SERVICE
  sed -i 's/ProtectHome=true/ProtectHome=false/g' $SERVICE
  sed -i 's/RestrictAddressFamilies=/RestrictAddressFamilies=AF_INET/g' $SERVICE
fi

## __Recarga de demonio__
echo -e "$cian Reiniciando servicio $default"
systemctl daemon-reload

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

