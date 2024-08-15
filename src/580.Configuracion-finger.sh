#!/bin/bash

# Configuración de finger

## __Autoría y licencia__
###### Configuración de finger © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$cian Instalando paquetes $default"
apt install -y finger-server oidentd

## __Configuración de variables__
UNIT='inetd'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER=''
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR=''
FILE=''
###### cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE

## __Endurecimiento de servicio__
sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE

## __Configuración de firewall__
echo -e "$cian Configurando firewall $default"
ufw allow 79/tcp comment $UNIT.fingerd

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



#greeting='# Te damos la bienvenida a nuestro servidor tilde de uso compartido.'
#plan="# En este fichero puedes indicarle a otras personas el plan en el que trabajas o a lo que te dedicas actualmente."
#project="# En este fichero puedes indicarle a otras personas el o los proyectos en los que trabajas actualmente."
#echo -e $"$greeting\n$plan\n" > /etc/skel/.plan
#echo -e $"$greeting\n$project\n" > /etc/skel/.project

cowthink 'Estoy trabajando en un nuevo proyecto.' > /etc/skel/.project
cowsay 'Estoy trabajando en un nuevo plan.' > /etc/skel/.plan
touch /etc/skel/.fingerlog
