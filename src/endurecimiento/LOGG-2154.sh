#!/bin/bash

# Endurecimiento LOGG-2154

## __Autoría y licencia__
###### Endurecimiento LOGG-2154 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [LOGG-2154]:(betterstack.com/community/guides/logging/how-to-configure-centralised-rsyslog-server/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='LOGG-2154'
UNIT='rsyslog'
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
PKG='rsyslog'
apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/rsyslog.d/'
FILE='loghost.conf'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
mkdir -p $DIR
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
## Remote logging client
*.* @@10.0.0.2:514
########################
" >> $DIR$FILE

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
logger "Probando $TEST"


## __Configuración del lado del servidor.__
# echo "
# ########################
# # Editado por ~ferorge #
# ########################
# #
# # $TEST
# #
# ## Remote logging server
# module(load="imtcp")
# input(type="imtcp" port="514")
# 
# $template RemoteLogs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
# *.* ?RemoteLogs
# & stop
# ########################
# " >> $DIR$FILE

# ufw allow 514/tcp comment remote-logging
# ufw reload
