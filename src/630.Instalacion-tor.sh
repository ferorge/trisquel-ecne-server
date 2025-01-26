#!/bin/bash

# Instalación de tor

## __Autoría y licencia__
###### Instalación de tor © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [Servicio cebolla]:(https://community.torproject.org/onion-services/setup/)

## __Configuración de variables__
UNIT='tor'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER='debian-tor'
VAR_DIR='/var/tor/'
RUN=''
timestamp=$(date +%F_%H.%M.%S)
VERSION=0.4.8.13

## __Instalación de paquetes__
echo -e "$CYAN Instalando paquetes $DEFAULT"
#apt install -y libevent openssl zlib libevent-dev

## __Compilación de tor__
#cd /opt/
#wget https://dist.torproject.org/tor-$VERSION.tar.gz
#tar xzf tor-$VERSION.tar.gz 
#cd tor-$VERSION
#./configure
#make
#make install

## __Creación de usuario__
id $USER > /dev/null
if [[ $? != 0 ]];then
  useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
fi

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/usr/local/etc/tor/'
FILE='torrc'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
grep ferorge $DIR$FILE > /dev/null
if [[ $? != 0 ]];then
echo '
########################
# Editado por ~ferorge #
########################
HiddenServiceDir /var/tor/
HiddenServicePort 80 unix:/var/run/tor/my-website.sock
' >> $DIR$FILE
fi

mkdir -p $VAR_DIR
chown debian-tor:debian-tor $VAR_DIR
mkdir -p /usr/local/var/tor
chown debian-tor:debian-tor /usr/local/var/tor
mkdir -p /var/run/tor/
chown debian-tor:debian-tor /var/run/tor

cat <<EOF > /etc/apache2/sites-available/onion.conf
     <VirtualHost *:80>
       ServerName $(cat /var/tor/hostname)
       DocumentRoot /var/www/html/public
       ErrorLog /var/log/apache2/onion.log
     </VirtualHost>
EOF

a2ensite onion

## __Modificación de esqueleto__
#source "${0%/*}"/107.1_01.skel-finger.sh

## __Creación de servicio__
cat <<EOF > $SERVICE
[Unit]
Description=tor onion service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/tor

[Install]
WantedBy=multi-user.target
EOF
chmod 0644 $SERVICE

## __Endurecimiento de servicio__
source "${0%/*}"/endurecimiento/BOOT-5264_tor.sh

## __Configuración de firewall__
echo -e "$CYAN Configurando firewall $DEFAULT"
ufw allow 9050/tcp comment $UNIT
ufw allow 9051/tcp comment torrc

## __Activación de servicio__
echo -e "$CYAN Activando servicio $DEFAULT"
systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$CYAN Reiniciando servicio $DEFAULT"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$CYAN Verificando servicio $DEFAULT"
systemctl status $UNIT

## __Verificación de configuración__
echo -e "$CYAN Verificando configuración $DEFAULT"


#wget -qO - https://check.torproject.org | grep Sorry
#torsocks wget -qO - https://check.torproject.org | grep Congratulations

# Configuracion
#wget -qO - https://api.ipify.org; echo
#torsocks wget -qO - https://api.ipify.org; echo

#echo -e "$RED Ejecutar como usuario lo siguiente: $DEFAULT"
#echo -e "torpass=$(tor --hash-password "3834t,T;0010")"
# No ejecutar como root
# torpass=$(tor --hash-password "3834t,T;0010")

#echo HashedControlPassword 16:E524B731C98EAEB860894C80FDA164A236ED723C3B8EB97E58BE01FB1E >> /etc/tor/torrc
#echo ControlPort 39051 >> /etc/tor/torrc
#tail -2 /etc/tor/torrc
