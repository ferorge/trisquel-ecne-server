#!/bin/bash

# Endurecimiento KRNL-5820

## __Autoría y licencia__
###### Endurecimiento KRNL-5820 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='KRNL-5820'
UNIT=''
PKG=systemd-coredump
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/systemd/coredump.conf.d/'
FILE="$TEST.conf"
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
ProcessSizeMax=0
Storage=none
########################
" >> $DIR$FILE


# __Respaldo de configuración__
DIR='/etc/'
FILE='profile'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

# __Modificacion de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
ulimit -c 0
########################
" >> $DIR$FILE

# __Respaldo de configuración__                                                    
DIR='/etc/security/limits.d/'
FILE='KRNL-5820.conf'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

# __Modificacion de configuración__                                                
echo -e "$cian Modificando $DIR$FILE $default"
mkdir -p $DIR
echo "                                                                             
########################                                                           
# Editado por ~ferorge #                                                           
########################                                                           
#                                                                                  
# $TEST                                                                            
#                                                                                  
* soft core 0
* hard core 0                                                                      
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

