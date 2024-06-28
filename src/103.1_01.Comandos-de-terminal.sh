#!/bin/bash

# Comandos de terminal

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/101-500/104/104.3/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Ver información del sistema
echo -e "\n $cian $(apropos -e uname | grep system) $default"
echo -e "\$ $rojo uname -a $default"

## Ver directorio actual
echo -e "\n $cian $(apropos -e pwd) $default"
echo -e "\$ $rojo pwd $default"

## Crear fichero vacío
echo -e "\n $cian $(apropos -e touch) $default"
echo -e "\$ $rojo touch test.txt $default"

## Ver contenido del directorio
echo -e "\n $cian $(apropos -e ls | grep list) $default"
echo -e "\$ $rojo ls $default"

## Ver manual de la aplicación
echo -e "\n $cian $(apropos -e man | grep manual) $default"
echo -e "\$ $rojo man man $default"

## Ver nombre y descripción de los manuales
echo -e "\n $cian $(apropos -e apropos) $default"
echo -e "\$ $rojo apropos apropos $default"

## Ver información sobre el tipo de comando.
echo -e "\n $cian $(hash --help | grep program) $default"
echo -e "\$ $rojo hash uname pwd touch ls man apropos hash $default"

## Ver las ubicaciones del programa.
echo -e "\n $cian $(type --help | grep about) $default"
echo -e "\$ $rojo type uname pwd touch ls man apropos hash $default"

## Ver la ubicación absoluta de un comando.
echo -e "\n $cian $(apropos which | head -n1) $default"
echo -e "\$ $rojo which uname pwd touch ls man apropos hash which $default"

## Ver comandos que hayan ejecutado previamente.
echo -e "\n $cian $(apropos history | head -n1) $default"
echo -e "\$ $rojo history 5 $default"










### Instalación de paquetes
#echo -e "$cian Instalando paquetes $default"
####### apt install -y 'package'
#
### Configuración de variables
#UNIT=''
#SERVICE="/lib/systemd/system/$UNIT.service"
#FQDN=$(hostname -f)
#USER=''
#VAR_DIR=''
#RUN=''
#timestamp=$(date +%F_%H.%M.%S)
#
### Creación de usuario
####### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
#
### Respaldo de configuración
#echo -e "$cian Respaldando configuracion $default"
#DIR=''
#FILE=''
####### cp $DIR$FILE /var/backups/$FILE.$timestamp
#
### Modificación de configuración
#echo -e "$cian Modificando configuracion $default"
####### echo '
#########################
## Editado por ~ferorge #
#########################
####### ' >> $DIR$FILE
#
### Endurecimiento de servicio
#sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
#sed -i "s/__USER__/$USER/g" $SERVICE
#sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
#sed -i -r "s#__RUN__#$RUN#g" $SERVICE
#
### Configuración de firewall
#echo -e "$cian Configurando firewall $default"
####### ufw allow 'puerto'/'protocolo' comment $UNIT
#
### Activación de servicio
#echo -e "$cian Activando servicio $default"
####### systemctl enable $UNIT
#
### Reinicio de servicio
#echo -e "$cian Reiniciando servicio $default"
####### systemctl restart $UNIT
#
### Verificación de servicio
#echo -e "$cian Verificando servicio $default"
####### systemctl status $UNIT
#
### Verificacion de configuracion
#echo -e "$cian Verificando configuracion $default"
