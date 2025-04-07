#!/bin/bash

# Endurecimiento SSH-7408

## __Autoría y licencia__
###### Endurecimiento SSH-7408 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [SSH-7408]:(https://linux-audit.com/ssh/audit-and-harden-your-ssh-configuration/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='SSH-7408'
UNIT='sshd'
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# PKG=''
# apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/ssh/sshd_config.d/'
FILE='SSH-7408.conf'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
mkdir -p $DIR
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
AllowTcpForwarding no
ClientAliveCountMax 2
ClientAliveInterval 0
Compression no
FingerprintHash SHA256
GatewayPorts no
IgnoreRhosts yes
LoginGraceTime 120
LogLevel verbose
MaxAuthTries 2
MaxSessions 2
PermitRootLogin no
PermitUserEnvironment no
PermitTunnel no
Port 30022
PrintLastLog yes
StrictModes yes
TCPKeepAlive no
UseDNS no
X11Forwarding no
AllowAgentForwarding no
AllowUsers *
AllowGroups staff users
########################
" >> $DIR$FILE

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
# echo -e "$cian Verificando configuración $default"

