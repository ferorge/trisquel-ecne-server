#!/usr/bin/env bash

# Instalación de servidor nfs 

## __Autoría y licencia__
###### Instalación de servidor nfs © 2026 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [Fuente]:(enlace)

## __Configuración de variables__
UNIT='nfs-server'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER=''
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
echo -e "$CYAN Instalando paquetes $DEFAULT"
apt install -y --no-install-recommends --no-install-suggests nfs-kernel-server

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/'
FILE='exports'
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificacion de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
echo '
########################
# Editado por ~ferorge #
########################
#
/var/nfs/share     10.0.0.0/24(rw,sync,secure,wdelay,subtree_check,no_all_squash)
' >> $DIR$FILE

### __Creación de directorio compartido__
mkdir -p /var/nfs/share

### __Exportación de sistema de ficheros__
exportfs

## __Endurecimiento de servicio__
source "${0%/*}"/endurecimiento/BOOT-5264_$UNIT.sh

## __Configuración de firewall__
echo -e "$CYAN Configurando firewall $DEFAULT"
ufw allow 2049/tcp comment $UNIT

## __Activación de servicio__
echo -e "$CYAN Activando servicio $DEFAULT"
systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$CYAN Reiniciando servicio $DEFAULT"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$CYAN Verificando servicio $DEFAULT"
systemctl status $UNIT

## __Verificación de configuración__
echo -e "$CYAN Verificando configuración $DEFAULT"
