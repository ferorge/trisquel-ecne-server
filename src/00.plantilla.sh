#!/bin/bash

# Título

## __Autoría y licencia__
###### Título © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
UNIT=''
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER=''
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
echo -e "$CYAN Instalando paquetes $DEFAULT"
###### apt install -y 'package'

## Creación de usuario
id $USER
if [[ $? != 0 ]];then
  useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
fi

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR=''
FILE=''
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
grep ferorge $DIR$FILE > /dev/null
if [[ $? != 0 ]];then
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE
fi

## __Endurecimiento de servicio__
sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE

## __Configuración de firewall__
echo -e "$CYAN Configurando firewall $DEFAULT"
###### ufw allow 'puerto'/'protocolo' comment $UNIT

## __Activación de servicio__
echo -e "$CYAN Activando servicio $DEFAULT"
###### systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$CYAN Reiniciando servicio $DEFAULT"
###### systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$CYAN Verificando servicio $DEFAULT"
###### systemctl status $UNIT

## __Verificación de configuración__
echo -e "$CYAN Verificando configuración $DEFAULT"
