#!/usr/bin/env bash

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
echo -e "$CYAN Instalando paquetes $DEFAULT"
apt install -y molly-brown amfora

## __Configuración de variables__
FQDN=$(hostname -f)
UNIT="molly-brown@$FQDN"
VAR_DIR='/var/gemini'
USERS_DIR="$VAR_DIR/users/"
timestamp=$(date +%F_%H.%M.%S)
USER=molly-brown

# Obtiene la lista de usuarios, considerando que todos pertenecen al grupo 100.
CURRENT_USERS=$(grep :100: /etc/passwd | grep -v x:100: | cut -d: -f1)

# Creación de usuario
id $USER
if [[ $? != 0 ]];then
  useradd --system --user-group --groups ssl-cert --comment molly-brown_daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
fi

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/molly-brown/'
FILE="$FQDN.conf"
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
grep -q ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo "
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
" >> $DIR$FILE
fi

mkdir -p $VAR_DIR/{gmi,log,users}
chmod -R 0775 $VAR_DIR

touch $VAR_DIR/log/{access,error}.log
chmod 0640 $VAR_DIR/log/{access,error}.log

chown -R molly-brown:molly-brown $VAR_DIR
chown -R molly-brown:staff $VAR_DIR/gmi

# Crea el directorio para cada usuario y otorga los permisos.
for user in $CURRENT_USERS
do
  ls /home/$user/public_gemini
  if [[ $? == 0 ]];then
    test -L /home/$user/public_gemini
    if [[ $? != 0 ]];then
      mv /home/$user/public_gemini $USERS_DIR$user
    fi
  else
    mkdir -p $USERS_DIR$user
  fi
  chown -R $user:molly-brown $USERS_DIR$user
#  chmod 0755 $USERS_DIR$user
  ln -s $USERS_DIR$user /home/$user/public_gemini
done

## __Modificación de index.gmi__
source "${0%/*}"/602.Modificacion-index.gmi.sh

## __Modificación de esqueleto__
source "${0%/*}"/107.1_01.skel-gemini.sh

## __Endurecimiento de servicio__
source "${0%/*}"/endurecimiento/BOOT-5264_molly-brown.sh

## __Configuración de firewall__
echo -e "$CYAN Configurando firewall $DEFAULT"
ufw allow 1965/tcp comment $UNIT

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
