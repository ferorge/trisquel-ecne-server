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
echo -e "$CYAN Instalando paquetes $DEFAULT"
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
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/apache2/conf-enabled/'
FILE='security.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
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
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/apache2/mods-enabled/'
FILE='dir.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
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
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/apache2/conf-available/'
FILE='cgi-enabled.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo "
########################
# Editado por ~ferorge #
########################
<Directory $VAR_DIR/html/public>
    Options +ExecCGI
    AddHandler cgi-script .cgi .py
</Directory>

<Directory /home/*/public_html>
    Options +ExecCGI
    AddHandler cgi-script .cgi .py
</Directory>
" >> $DIR$FILE
fi

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/etc/apache2/'
FILE='apache2.conf'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
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
mkdir -p $VAR_DIR/html/public/
chmod -R 0755 $VAR_DIR

### Adición de ico y css.
cp "${0%/*}"/html/{favicon.ico,lynx.css} $VAR_DIR/html/public/

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
  ln -s $USERS_DIR$user /home/$user/public_html
done

## __Configuración de virtual host__
source "${0%/*}"/612.Configuracion-VirtualHost.sh

## __Configuración de index.html__
source "${0%/*}"/614.Modificacion-index.html.sh
ln -s "${0%/*}"/614.Modificacion-index.html.sh /etc/cron.hourly/Modificar-index.html

## __Modificación de esqueleto__
source "${0%/*}"/107.1_01.skel-http.sh

## __Endurecimiento de servicio__
source "${0%/*}"/endurecimiento/BOOT-5264_apache2.sh

## __Desactivación de sitios__
a2dissite 000-default
a2dissite default-ssl

## __Configuración de SSL/TLS__
echo -e "$CYAN Configurando SSL/TLS $DEFAULT"
a2enmod ssl

## __Configuracion de UserDir__
echo -e "$CYAN Configurando userdir $DEFAULT"
a2enmod userdir

## __Configuracion de cgid__
echo -e "$CYAN Configurando cgid $DEFAULT"
a2enmod cgid

## __Endurecimiento de servicio__
sed "/\[Service\]/r ${0%/*}/00.plantilla-de-servicios-systemd.txt" $SERVICE
sed -i "s/__USER__/$USER/g" $SERVICE
sed -i -r "s#__PATH__#$VAR_DIR#g" $SERVICE
sed -i -r "s#__RUN__#$RUN#g" $SERVICE

## __Configuración de firewall__
echo -e "$CYAN Configurando firewall $DEFAULT"
ufw allow 80/tcp comment HTTP
ufw allow 443/tcp comment HTTPS

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
echo -e "$CYAN Verificando sitio HTTP $DEFAULT"
curl http://$FQDN
echo -e "$CYAN Verificando sitio HTTPS $DEFAULT"
curl https://$FQDN
echo -e "$CYAN Verificando UserDir HTTP $DEFAULT"
curl http://$FQDN/~$user/
echo -e "$CYAN Verificando UserDir HTTPS $DEFAULT"
curl https://$FQDN/~$user/
