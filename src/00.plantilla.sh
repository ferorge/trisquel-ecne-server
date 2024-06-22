#!/bin/bash

# Configuración de plantilla

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
###### apt install -y 'package'

## Configuración de variables
UNIT=''
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER=''
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## Respaldo de configuración
echo -e "$cian Respaldando configuracion $default"
DIR=''
FILE=''
###### cp $DIR$FILE /var/backups/$FILE.$timestamp

## Modificación de configuración
echo -e "$cian Modificando configuracion $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE

## Endurecimiento de servicio
sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE

## Configuración de firewall
echo -e "$cian Configurando firewall $default"
###### ufw allow 'puerto'/'protocolo' comment $UNIT

## Activación de servicio
echo -e "$cian Activando servicio $default"
###### systemctl enable $UNIT

## Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
###### systemctl restart $UNIT

## Verificación de servicio
echo -e "$cian Verificando servicio $default"
###### systemctl status $UNIT

## Verificacion de configuracion
echo -e "$cian Verificando configuracion $default"
