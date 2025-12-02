#!/usr/bin/env bash

# Configuración de finger

## __Autoría y licencia__
###### Configuración de finger © 2024 por \~ferorge
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
apt install -y finger-server oidentd

## __Configuración de variables__
UNIT='inetutils-inetd'
FQDN=$(hostname -f)
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/cfingerd/'
FILE='cfingerd.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
sed -i "s/-ALLOW_NONIDENT_ACCESS/+ALLOW_NONIDENT_ACCESS/g" $DIR$FILE

echo '
########################
# Editado por ~ferorge #
########################
###### -ALLOW_NONIDENT_ACCESS -> +ALLOW_NONIDENT_ACCESS
' >> $DIR$FILE

## __Modificación de top finger__
source "${0%/*}"/581.Modificacion-top-finger.sh

## __Modificación de bottom finger__
source "${0%/*}"/582.Modificacion-bottom-finger.sh

## __Modificación de esqueleto__
source "${0%/*}"/107.1_01.skel-finger.sh

## __Endurecimiento de servicio__
source "${0%/*}"/endurecimiento/BOOT-5264_inetutils-inetd.sh

## __Configuración de firewall__
echo -e "$CYAN Configurando firewall $DEFAULT"
ufw allow 79/tcp comment $UNIT.cfingerd

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
