#!/bin/bash

# Configuración de virtual host

## __Autoría y licencia__
###### Configuración de virtual host © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
UNIT='apache2'
FQDN=$(hostname -f)
USER='www-data'
VAR_DIR='/var/www/html/'
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/apache2/sites-available/'
FILE="$FQDN.conf"
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo "
########################
# Editado por ~ferorge #
########################

#============================================================================#
# Basic admin setings                                                        #
#============================================================================#

ServerName $FQDN
ServerAdmin ferorge@texto-plano.xyz
CustomLog /var/log/apache2/html.access.log combined
ErrorLog /var/log/apache2/html.error.log

#============================================================================#
# Site settings                                                              #
#============================================================================#

DocumentRoot $VAR_DIR/public

<VirtualHost *:80>
    ServerAlias www.$FQDN
</VirtualHost>

<VirtualHost *:443>
    ServerAlias www.$FQDN

    #========================================================================#
    # SSL configuration                                                      #
    #========================================================================#

    SSLEngine on
    SSLProtocol -ALL -SSLv2 -SSLv3 +TLSv1 +TLSv1.1 +TLSv1.2
    SSLHonorCipherOrder on
    SSLCipherSuite TLSv1.2:RC4:HIGH:!aNULL:!eNULL:!MD5
    SSLCompression off
    TraceEnable Off
    SSLCertificateFile "/etc/letsencrypt/live/$FQDN/fullchain.pem"
    SSLCertificateKeyFile "/etc/letsencrypt/live/$FQDN/privkey.pem"
</VirtualHost>
" > $DIR$FILE
fi

certbot certonly --webroot -w $VAR_DIR -d $FQDN
a2ensite $FQDN
mkdir -p $VAR_DIR/public
chown -R $USER:$USER $VAR_DIR
chmod -R 0444 $VAR_DIR/public

## __Reinicio de servicio__
echo -e "$cian Reiniciando servicio $default"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "$cian Verificando servicio $default"
systemctl status $UNIT

## __Verificación de configuración__
echo -e "$cian Verificando configuración $default"

