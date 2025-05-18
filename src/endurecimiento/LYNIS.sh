#!/bin/bash

# Endurecimiento LYNIS

## __Autoría y licencia__
###### Endurecimiento LYNIS © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='LYNIS'
UNIT=''
DIR='/opt/'
FILE='lynis'
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
PKG='lynis git'
apt install -y $PKG

echo -e "$cian Instalando $PACK $default"
apt install -y $PACK

$DIR$FILE/lynis update check
if [ $? -eq 1 ]; then

## __Respaldo de configuración__
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
# mkdir -p $DIR
# echo "
# ########################
# # Editado por ~ferorge #
# ########################
# #
# # $TEST
# #
# ########################
# " >> $DIR$FILE
cd $DIR
git clone https://github.com/CISOfy/lynis
fi

## __Activación de servicio__
# echo -e "$cian Activando servicio $default"
# systemctl enable $UNIT

## __Reinicio de servicio__
# echo -e "$cian Reiniciando servicio $default"
# systemctl restart $UNIT

## __Verificación de servicio__
# echo -e "$cian Verificando servicio $default"
# systemctl status $UNIT

## __Verificacion de configuración__
# echo -e "$cian Verificando configuración $default"

