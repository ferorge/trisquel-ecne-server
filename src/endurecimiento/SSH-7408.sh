#!/bin/bash

# Endurecimiento SSH-7408

## __Autoría y licencia__
###### Endurecimiento SSH-7408 © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='SSH-7408'
UNIT='sshd'
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/ssh/sshd_config.d/'
FILE="$TEST.conf"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
AllowTcpForwarding NO
ClientAliveCountMax 2
ClientAliveInterval 0
Compression NO
FingerprintHash SHA256
GatewayPorts NO
IgnoreRhosts YES
LoginGraceTime 120
LogLevel VERBOSE
MaxAuthTries 2
MaxSessions 2
PermitRootLogin NO
PermitUserEnvironment NO
PermitTunnel NO
Port 30022
PrintLastLog YES
StrictModes YES
TCPKeepAlive NO
UseDNS NO
X11Forwarding NO
AllowAgentForwarding NO
AllowUsers *
AllowGroups fernando registro users
########################
" > $DIR$FILE

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

