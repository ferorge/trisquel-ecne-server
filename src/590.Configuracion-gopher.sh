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
echo -e "$cian Instalando paquetes $default"
apt install -y gophernicus

## __Configuración de variables__
UNIT='gophernicus.socket'
VAR_DIR='/var/gopher/'
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/default/'
FILE='gophernicus'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
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
echo -e "$cian Configurando firewall $default"
ufw allow 70/tcp comment $UNIT

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


