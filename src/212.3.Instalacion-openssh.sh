#!/bin/bash

# Instalación de servidor openssh

## __Autoría y licencia__
###### Instalación de servidor openssh © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
apt install -y openssh-server

## __Configuración de variables__
UNIT='ssh'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER='sshd'
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/ssh'
FILE=''
###### cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE

## __Endurecimiento de servicio__
sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
###### sed -i "s/__USER__/$USER/g" $SERVICE
###### sed -i "s/__USER__/$USER/g" $SERVICE
###### sed -i -r "s#__RUN__#$RUN#g" $SERVICE
###### sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i 's/CapabilityBoundingSet=/CapabilityBoundingSet=~CAP_AUDIT_* CAP_FOWNER CAP_IPC_OWNER CAP_DAC_* CAP_BPF CAP_KILL CAP_FSETID CAP_SETFCAP CAP_LEASE CAP_LINUX_IMMUTABLE CAP_IPC_LOCK CAP_BLOCK_SUSPEND CAP_SYS_ADMIN CAP_SYS_RAWIO CAP_SYS_PTRACE CAP_SYS_BOOT CAP_SYS_PACCT CAP_SYS_NICE CAP_SYS_RESOURCE CAP_SYS_TTY_CONFIG CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_BROADCAST CAP_NET_RAW CAP_SETPCAP/g' $SERVICE
sed -i 's/PrivateUsers=true/PrivateUsers=false/g' $SERVICE
sed -i 's/ProcSubset=pid/#ProcSubset=pid/g' $SERVICE
sed -i 's/ProtectSystem=strict/#ProtectSystem=strict/g' $SERVICE
sed -i 's/RestrictAddressFamilies=/RestrictAddressFamilies=AF_INET AF_UNIX/g' $SERVICE
sed -i 's/SystemCallFilter=@system-service/SystemCallFilter=~@clock @cpu-emulation @debug @module @obsolete @raw-io @reboot @swap/g' $SERVICE
###### Permite elevar a permisos de root.
sed -i 's/NoNewPrivileges=true/NoNewPrivileges=false/g' $SERVICE
###### Permite acceder a /tmp
sed -i 's/PrivateTmp=true/PrivateTmp=false/g' $SERVICE
###### Permite acceder a /home
sed -i 's/ProtectHome=true/ProtectHome=false/g' $SERVICE

## __Configuración de firewall__
echo -e "$cian Configurando firewall $default"
ufw allow 30022/tcp comment $UNIT

## __Activación de servicio__
echo -e "$cian Activando servicio $default"
systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

## __Verificacion de configuración__
echo -e "$cian Verificando configuración $default"
