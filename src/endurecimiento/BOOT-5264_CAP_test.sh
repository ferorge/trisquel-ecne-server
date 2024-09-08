#!/bin/bash

# BOOT-5264 CAP test

## __Autoría y licencia__
###### BOOT-5264 CAP test © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
UNIT='gophernicus@'
SERVICE="/lib/systemd/system/$UNIT.service"
timestamp=$(date +%F_%H.%M.%S)

## __Endurecimiento de servicio__
#if [[ $? != 0 ]];then
#fi
CAPS="CAP_AUDIT_*
CAP_SETUID
CAP_SETGID
CAP_SETPCAP
CAP_DAC_*
CAP_FOWNER
CAP_IPC_OWNER
CAP_CHOWN
CAP_FSETID
CAP_SETFCAP
CAP_BPF
CAP_KILL
CAP_LEASE
CAP_LINUX_IMMUTABLE
CAP_IPC_LOCK
CAP_BLOCK_SUSPEND
CAP_SYS_ADMIN
CAP_SYS_RAWIO
CAP_SYS_PTRACE
CAP_SYS_BOOT
CAP_SYS_PACCT
CAP_SYS_NICE
CAP_SYS_RESOURCE
CAP_SYS_TTY_CONFIG
CAP_NET_ADMIN
CAP_NET_BIND_SERVICE
CAP_NET_BROADCAST
CAP_NET_RAW
CAP_SYS_CHROOT
CAP_MAC_*"

echo '' > /tmp/CAP_test.txt

for CAP in $CAPS
do
  echo $CAP
  sed -i "s/CapabilityBoundingSet=~/CapabilityBoundingSet=~$CAP /g" $SERVICE
  grep CapabilityBoundingSet $SERVICE
  systemctl daemon-reload
  systemctl restart $UNIT
  systemctl status $UNIT
  if [[ $? != 0 ]];then
    sed -i "s/$CAP //g" $SERVICE
  fi
  echo $? $CAP >> /tmp/CAP_test.txt
done
cat /tmp/CAP_test.txt


