#!/bin/bash

# Configuración de apache2

## __Autoría y licencia__
###### Configuración de apache2 © 2024 por \~ferorge
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
apt -y install apache2 curl certbot

## __Configuración de variables__
UNIT='apache2'
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER='www-data'
VAR_DIR='/var/www'
USERS_DIR="$VAR_DIR/users"
RUN=''
timestamp=$(date +%F_%H.%M.%S)

### Obtiene la lista de usuarios, considerando que todos pertenecen al grupo 100.
CURRENT_USERS=$(grep :100: /etc/passwd | grep -v x:100: | cut -d: -f1)

## Creación de usuario
id $USER
if [[ $? != 0 ]];then
  useradd --system --user-group --groups ssl-cert --comment $USER-daemon --home-dir $VAR_DIR --shell /usr/sbin/nologin $USER
fi

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/apache2/conf-enabled/'
FILE='security.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo '
########################
# Editado por ~ferorge #
########################
ServerTokens Prod
ServerSignature On
TraceEnable Off
' >> $DIR$FILE
fi

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/apache2/mods-enabled/'
FILE='dir.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo '
########################
# Editado por ~ferorge #
########################
<IfModule mod_dir.c>
	DirectoryIndex index.html index.py index.php
</IfModule>
' >> $DIR$FILE
fi

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/apache2/'
FILE='apache2.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo '
########################
# Editado por ~ferorge #
########################
echo "
ServerName $FQDN
" >> $DIR$FILE
fi

### Creación de directorios.
mkdir -p $VAR_DIR/{html,log,users}
chmod -R 0755 $VAR_DIR

### Adición de ico y css.
cp "${0%/*}"/html/{favicon.ico,lynx.css} $DIR

### Adición de logs.
touch $VAR_DIR/log/{access,error}.log
chmod 0640 $VAR_DIR/log/{access,error}.log

### Configuración de permisos.
chown -R $USER:$USER $VAR_DIR
chown -R $USER:staff $VAR_DIR

### Crea el directorio para cada usuario y otorga los permisos.
for user in $CURRENT_USERS
do
  ls /home/$user/public_html
  if [[ $? == 0 ]];then
    test -L /home/$user/public_html
    if [[ $? != 0 ]];then
      mv /home/$user/public_html $USERS_DIR$user
    fi
  else
    mkdir -p $USERS_DIR$user
  fi
  chown -R $user:$USER $USERS_DIR$user
#  chmod 0755 $USERS_DIR$user
  ln -s $USERS_DIR$user /home/$user/public_html
done

## __Configuración de virtual host__
source "${0%/*}"/612.Configuracion-VirtualHost.sh

## __Configuración de index.html__
source "${0%/*}"/614.Modificacion-index.html.sh

## __Modificación de esqueleto__
source "${0%/*}"/107.1_01_skel-http.sh

## __Endurecimiento de servicio__
source "${0%/*}"/endurecimiento/BOOT-5264_apache2.sh

## __Desactivación de sitios__
a2dissite 000-default
a2dissite default-ssl

## __Configuración de SSL/TLS__
echo -e "$cian Configurando SSL/TLS $default"
a2enmod ssl

## __Configuracion de UserDir__
echo -e "$cian Configurando userdir $default"
a2enmod userdir

## __Endurecimiento de servicio__
sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE

## __Configuración de firewall__
echo -e "$cian Configurando firewall $default"
ufw allow 80/tcp comment HTTP
ufw allow 443/tcp comment HTTPS

## __Activación de servicio__
echo -e "$cian Activando servicio $default"
systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

## __Verificación de configuración__
echo -e "$cian Verificando configuración $default"
echo -e "$cian Verificando sitio HTTP $default"
curl http://$FQDN
echo -e "$cian Verificando sitio HTTPS $default"
curl https://$FQDN
echo -e "$cian Verificando UserDir HTTP $default"
curl http://$FQDN/~$user/
echo -e "$cian Verificando UserDir HTTPS $default"
curl https://$FQDN/~$user/
