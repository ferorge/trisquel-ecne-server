#!/usr/bin/env bash

# Configuración de ntpd

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/102-500/108/108.1/108.1_02/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$CYAN Instalando paquetes $DEFAULT"
apt install -y ntpsec

## Configuración de variables
UNIT='ntpsec'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER="$UNIT"
VAR_DIR='/var/log/ntpsec/'
RUN=''
DIR='/etc/$UNIT/'
FILE='ntp.conf'
CFG="$UNIT"
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
echo -e "$CYAN Creando usuario $DEFAULT"
mkdir -p $VAR_DIR
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## Respaldo de configuración
echo -e "$CYAN Respaldando configuración $DEFAULT"
##### #cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## Modificación de configuración
echo -e "$CYAN Modificando configuración $DEFAULT"
###### echo "
##########################
### Editado por ~ferorge #
##########################
###### " >> $DIR$FILE

## Endurecimiento de servicio
cp $SERVICE /var/local/backups/$UNIT.service.$timestamp
sed -i "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i "s/__GROUP__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
###### sed -i -r "s#__RUN__#$RUN#g" $SERVICE
sed -i "s/__CFG__/$CFG/g" $SERVICE

## Configuracion de firewall
echo -e "$CYAN Configurando firewall $DEFAULT"
ufw allow 123/tcp comment $UNIT

## Activación de servicio
echo -e "$CYAN Activando servicio $DEFAULT"
systemctl enable $UNIT

## Reinicio de servicio
echo -e "$CYAN Reiniciando servicio $DEFAULT"
systemctl restart $UNIT

## Verificación de servicio
echo -e "$CYAN Verificando servicio $DEFAULT"
systemctl status $UNIT

## Verificación de configuración
echo -e "$CYAN Verificando configuración $DEFAULT"
ntpq -p
