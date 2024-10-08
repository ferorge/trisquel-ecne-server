#!/bin/bash

# Endurecimiento BOOT-5264 apache2

## __Autoría y licencia__
###### Endurecimiento BOOT-5264 apache2 © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
FQDN=$(hostname -f)
UNIT='apache2'
SERVICE="/lib/systemd/system/$UNIT.service"
USER='www-data'
VAR_DIR='/var/www/'
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
cp $SERVICE /var/backups/$UNIT.service.$timestamp

## __Endurecimiento de servicio__
grep -q Endurecido $SERVICE
if [[ $? != 0 ]];then
  sed -i "/\[Service\]/r ${0%/*}/../00.plantilla-de-servicios-systemd.txt" $SERVICE
  sed -i "0,/Type/s/Type=/#Type=/" $SERVICE
  sed -i "0,/Restart/s/Restart=/#Restart=/" $SERVICE
  sed -i "s/User=/#User=/" $SERVICE
  sed -i "s/Group=/#Group=/g" $SERVICE
  sed -i "s/ReadWritePaths=/#ReadWritePaths=/g" $SERVICE
  sed -i 's/CapabilityBoundingSet=/\#CapabilityBoundingSet=/g' $SERVICE
  sed -i 's/ProtectSystem=/\#ProtectSystem=/g' $SERVICE
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

