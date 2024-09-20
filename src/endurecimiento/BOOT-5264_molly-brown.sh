#!/bin/bash

# Endurecimiento BOOT-5264 inetd

## __Autoría y licencia__
###### Endurecimiento BOOT-5264 inetd © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
UNIT='gophernicus@'
SERVICE="/lib/systemd/system/$UNIT.service"
USER='_gophernicus'
VAR_DIR='/var/gopher/'
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
mkdir -p $VAR_DIR
chown $USER:$USER $VAR_DIR
id $USER
if [[ $? != 0 ]];then
  useradd --system --user-group --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
fi

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
cp $SERVICE /var/backups/$UNIT.service.$timestamp

## __Endurecimiento de servicio__
grep -q Endurecido $SERVICE
if [[ $? != 0 ]];then
  sed -i "/\[Service\]/r ${0%/*}/../00.plantilla-de-servicios-systemd.txt" $SERVICE
  sed -i "s/Type=/\#Type=/g" $SERVICE
  sed -i "s/Restart=/\#Restart=/g" $SERVICE
  sed -i "0,/User/s/User=/User=$USER/" $SERVICE
  sed -i "s/Group=/Group=$USER/g" $SERVICE
  ###### sed -i -r "s#__RUN__#$RUN#g" $SERVICE
  sed -i "s,/tmp,$VAR_DIR,g" $SERVICE
#  sed -i 's/CapabilityBoundingSet=/\#CapabilityBoundingSet=/g' $SERVICE
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

#!/bin/bash

# Configuración de gemini

## __Autoría y licencia__
###### Configuración de gemini © 2024 por \~ferorge
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
apt install -y molly-brown amfora

## __Configuración de variables__
UNIT='molly-brown@default'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
VAR_DIR='/var/gemini'
timestamp=$(date +%F_%H.%M.%S)

## Creación de usuario
###### useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/molly-brown/'
FILE='default.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
echo '
########################
# Editado por ~ferorge #
########################
Hostname = '$FQDN'
Port = 1965
CertPath = '/etc/letsencrypt/live/$FQDN/cert.pem'
KeyPath = '/etc/letsencrypt/live/$FQDN/privkey.pem'
DocBase = '$VAR_DIR/'
HomeDocBase = 'users/'
AccessLog = '$VAR_DIR/log/access.log'
ErrorLog = '$VAR_DIR/log/error.log'
' >> $DIR$FILE
mkdir -p $VAR_DIR/{gmi,log,users}

chmod -R 0755 $VAR_DIR

cowsay 'El servidor gemini funciona correctamente.' | sed 's/^/# /' | sed 's/^#   /##  /' > $VAR_DIR/index.gmi
chmod 0444 $VAR_DIR/index.gmi

touch $VAR_DIR/log/{access,error}.log
chmod 0640 $VAR_DIR/log/{access,error}.log

chown -R molly-brown:molly-brown $VAR_DIR

## __Endurecimiento de servicio__
sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE

## __Configuración de firewall__
echo -e "$cian Configurando firewall $default"
ufw allow 1965/tcp comment $UNIT

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


# Obtiene la lista de usuarios, considerando que todos pertenecen al grupo 100.
CURRENT_USERS=$(grep :100: /etc/passwd | grep -v x:100: | cut -d: -f1)
USER=molly-brown
RUN='/usr/bin/molly-brown -c /etc/molly-brown/%i.conf'
SERVICE= '/lib/systemd/system/molly-brown@.service'

# Creación de usuario
useradd --system --user-group --groups ssl-cert --comment molly-brown_daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER

# Modificacion de configuracion
echo -e "$cian Modificando configuracion $default"

# Agregar directorio y fichero a skel
SKEL_DIR='/etc/skel/public_gemini/'
mkdir $SKEL_DIR
chmod 0755 $SKEL_DIR
cowsay -f pocho 'Bienvenide a mi cápsula gemini libre, pública y soberana.' > $SKEL_DIR'.mollyhead'
sed -i "1,4 s/^/##/g" $SKEL_DIR'.mollyhead'
sed -i "5,$ s/^/#/g" $SKEL_DIR'.mollyhead'
echo '' >> $SKEL_DIR'.mollyhead'
chmod 0644 $SKEL_DIR'.mollyhead'

# Crea el directorio para cada usuario y otorga los permisos.
USERS_DIR="$VAR_DIR/users/"
for user in $CURRENT_USERS
do
  mkdir $USERS_DIR$user
  chown $user:molly-brown $USERS_DIR$user
  chmod 755 $USERS_DIR$user
  ln -s $USERS_DIR$user /home/$user/public_gemini
done

# Endurecimiento de servicio
sed "/\[Service\]/r /opt/template-service.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE

