#!/bin/bash

SERVICIO=servicio

source "${0%/*}"/000.Colores.sh

timestamp=$(date +%F_%H.%M.%S)

FQDN=$(hostname -f)
USER=''
VAR_DIR=''
RUN=''
SERVICE=''

# Instalacion de paquetes
echo -e "$cian Instalando paquetes $default"
# apt install -y 'paquete'

# Creación de usuario
useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

# Respaldo de configuracion
echo -e "$cian Respaldando configuracion $default"
# directory=''
# file=''
# cp $directory$file /var/backups/$file.$timestamp

# Modificacion de configuracion
echo -e "$cian Modificando configuracion $default"
# echo '
#####################
# Editado por FORGE #
#####################
#
# ' >> $directory$file

# Endurecimiento de servicio
sed "/\[Service\]/r /opt/template-service.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE


# Verificacion de configuracion
echo -e "$cian Verificando configuracion $default"

# Configuracion de firewall
echo -e "$cian Configurando firewall $default"
# ufw allow 'puerto'/'protocolo' comment $SERVICIO

# Reinicio de servicio
echo -e "$cian Reiniciando servicio $default"
# systemctl restart $SERVICIO

# Activacion de servicio
echo -e "$cian Activando servicio $default"
# systemctl enable $SERVICIO

# Verificacion de servicio
echo -e "$cian Verificando servicio $default"
# systemctl status $SERVICIO
