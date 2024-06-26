#!/bin/bash

# Configuración de ntpd

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/102-500/108/108.1/108.1_02/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
apt install -y chrony

## Configuración de variables
UNIT='chrony'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER="_chrony"
VAR_DIR='/var/log/chrony/'
RUN=''
DIR='/etc/chrony/'
FILE='$UNIT.conf'
CFG="$UNIT"
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
echo -e "$cian Creando usuario $default"
###### mkdir -p $VAR_DIR
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## Respaldo de configuración
echo -e "$cian Respaldando configuración $default"
##### #cp $DIR$FILE /var/backups/$FILE.$timestamp

## Modificación de configuración
echo -e "$cian Modificando configuración $default"
###### echo "
##########################
### Editado por ~ferorge #
##########################
###### " >> $DIR$FILE

## Endurecimiento de servicio
cp $SERVICE /var/backups/$UNIT.service.$timestamp
sed -i "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i "s/__GROUP__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
###### sed -i -r "s#__RUN__#$RUN#g" $SERVICE
sed -i "s/__CFG__/$CFG/g" $SERVICE

## Configuracion de firewall
echo -e "$cian Configurando firewall $default"
ufw allow 123/tcp comment $UNIT

## Activación de servicio
echo -e "$cian Activando servicio $default"
systemctl enable $UNIT

## Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## Verificación de servicio
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

## Verificación de configuración
echo -e "$cian Verificando configuración $default"
chronyc sources

