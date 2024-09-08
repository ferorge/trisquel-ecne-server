#!/bin/bash

# Endurecimiento BOOT-5264 inetd

## __Autoría y licencia__
###### Endurecimiento BOOT-5264 inetd © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
UNIT='gophernicus@'
SERVICE="/lib/systemd/system/$UNIT.service"
USER='_gophernicus'
VAR_DIR='/var/gopher/'
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
mkdir -p $VAR_DIR
chown $USER:$USER $VAR_DIR
id $USER
if [[ $? != 0 ]];then
  useradd --system --user-group --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
fi

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
cp $SERVICE /var/backups/$UNIT.service.$timestamp

## __Endurecimiento de servicio__
grep -q Endurecido $SERVICE
if [[ $? != 0 ]];then
  sed -i "/\[Service\]/r ${0%/*}/../00.plantilla-de-servicios-systemd.txt" $SERVICE
  sed -i "s/Type=/\#Type=/g" $SERVICE
  sed -i "s/Restart=/\#Restart=/g" $SERVICE
  sed -i "0,/User/s/User=/User=$USER/" $SERVICE
  sed -i "s/Group=/Group=$USER/g" $SERVICE
  ###### sed -i -r "s#__RUN__#$RUN#g" $SERVICE
  sed -i "s,/tmp,$VAR_DIR,g" $SERVICE
#  sed -i 's/CapabilityBoundingSet=/\#CapabilityBoundingSet=/g' $SERVICE
  sed -i 's/PrivateNetwork=true/PrivateNetwork=false/g' $SERVICE
  sed -i 's/PrivateUsers=true/PrivateUsers=false/g' $SERVICE
  sed -i 's/ProtectHome=true/ProtectHome=false/g' $SERVICE
  sed -i 's/RestrictAddressFamilies=/RestrictAddressFamilies=AF_INET/g' $SERVICE
fi

## __Recarga de demonio__
echo -e "$cian Recargando demonio $default"
systemctl daemon-reload

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

