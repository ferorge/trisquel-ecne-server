#!/bin/bash

# Instalación de tor

## __Autoría y licencia__
###### Instalación de tor © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
UNIT='tor'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER=''
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)
VERSION=0.4.8.13

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Instalación de paquetes__
echo -e "$cian Instalando paquetes $default"
apt install -y libevent openssl zlib libevent-dev

## __Compilación de tor__
cd /opt/
wget https://dist.torproject.org/tor-$VERSION.tar.gz
tar xzf tor-$VERSION.tar.gz 
cd tor-$VERSION
./configure
make
make install

## Creación de usuario
id $USER
if [[ $? != 0 ]];then
  useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
fi

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR=''
FILE=''
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
grep ferorge $DIR$FILE
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
echo -e "$cian Configurando firewall $default"
ufw allow 9050/tcp comment $UNIT
ufw allow 9051/tcp comment torrc

## __Activación de servicio__
echo -e "$cian Activando servicio $default"
###### systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
###### systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
###### systemctl status $UNIT

## __Verificación de configuración__
echo -e "$cian Verificando configuración $default"
#wget -qO - https://check.torproject.org | grep Sorry
#torsocks wget -qO - https://check.torproject.org | grep Congratulations

# Configuracion
#wget -qO - https://api.ipify.org; echo
#torsocks wget -qO - https://api.ipify.org; echo

#echo -e "$rojo Ejecutar como usuario lo siguiente: $default"
#echo -e "torpass=$(tor --hash-password "3834t,T;0010")"
# No ejecutar como root
# torpass=$(tor --hash-password "3834t,T;0010")

#echo HashedControlPassword 16:E524B731C98EAEB860894C80FDA164A236ED723C3B8EB97E58BE01FB1E >> /etc/tor/torrc
#echo ControlPort 39051 >> /etc/tor/torrc
#tail -2 /etc/tor/torrc
