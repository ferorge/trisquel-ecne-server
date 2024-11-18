#!/bin/bash

# Configuración de gopher

## __Autoría y licencia__
###### Configuración de gopher © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$CYAN Instalando paquetes $DEFAULT"
apt install -y gophernicus

## __Configuración de variables__
UNIT='gophernicus.socket'
VAR_DIR='/var/gopher/'
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/default/'
FILE='gophernicus'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
echo '
########################
# Editado por ~ferorge #
########################
OPTIONS=-nx -r /var/gopher ' >> $DIR$FILE

mkdir -p $VAR_DIR
chmod 0755 $VAR_DIR

## __Modificación de gophermap__
source "${0%/*}"/592.Modificacion-gophermap.sh

## __Modificación de esqueleto__
source "${0%/*}"/107.1_01.skel-gopher.sh

## __Endurecimiento de servicio__
source "${0%/*}"/endurecimiento/BOOT-5264_gophernicus.sh

## __Configuración de firewall__
echo -e "$CYAN Configurando firewall $DEFAULT"
ufw allow 70/tcp comment $UNIT

## __Activación de servicio__
echo -e "$CYAN Activando servicio $DEFAULT"
systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$CYAN Reiniciando servicio $DEFAULT"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$CYAN Verificando servicio $DEFAULT"
systemctl status $UNIT

## __Verificacion de configuración__
echo -e "$CYAN Verificando configuración $DEFAULT"


