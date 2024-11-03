#!/bin/bash

# Verificación de zona en dynv6.com

## __Autoría y licencia__
###### Verificación de zona en dynv6.com © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [Documentación en dynv6.com]:(https://dynv6.com/docs/apis)

## __Configuración de variables__
HOST=$(hostname -s)
FQDN=$(hostname -f)
CURRENT_IP=$(curl -s ifconfig.me)
WD='/var/local/ubuntu-noble-server/src'

## __Cambio de directorio de trabajo__
###### Es necesario cuando el script es ejecutado a través de un enlace
###### simbólico en cron.
cd $WD

## __Importación de colores__
source $WD/000.Colores.sh

###### Token HTTP de la cuenta en dynv6.com
TOKEN=$(cat /var/local/dynv6_token.txt)

## __Obtención de IP de la zona__
JSON=$(curl -s \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/json" \
    http://dynv6.com/api/v2/zones)

ZONE_IP=$(echo $JSON | grep $FQDN | grep -o '"ipv4address":"[^"]*' | grep -o '[^"]*$')

## __Modificación de configuración__
if [[ $CURRENT_IP != $ZONE_IP ]]; then
  source $WD/109.2_01.a.Configuracion-nombre-hospedador.sh
  source $WD/109.2_01.b.Configuracion-nombres-red.sh
  UPDATE=$(curl -s "http://ipv4.dynv6.com/api/update?zone=$FQDN&ipv4=auto&token=$TOKEN")
  logger $UPDATE
  CURRENT_IP=$(curl -s ifconfig.me)
  ZONE_IP=$(echo $JSON | grep -o '"ipv4address":"[^"]*' | grep -o '[^"]*$')
  logger 'current IP: ' $CURRENT_IP
  logger "$HOST IP: " $ZONE_IP
else
  logger "$HOST equal current IP: $CURRENT_IP"
fi

## __Verificacion de periodicidad__
logger "Verificando periodicidad"
###### Busca todos los enlaces simbólicos dentro de los directorios cron  
###### y lo filtra con el nombre de este guion.
find /etc/cron.* -type l -ls | grep $(basename $0)
if [[ $? != 0 ]];then
  logger 'Revisión periódica desactivada.'
fi
