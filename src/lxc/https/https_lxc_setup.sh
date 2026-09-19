#!/usr/bin/env bash
#
## Configuración de apache2 con SSL
#
### __Descripción__
#
# Guión para configurar el servidor https.
#
### __Requisitos__
#
#### _Paquetes_
#
# * bash 4.0 o superior
#
### __Uso__
#
#    ./https_lxc_setup.sh
#
### __Autor__
#
# Configuración de apache2 con SSL © 2026 por \~ferorge
# [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
#
### __Licencia__
#
# Licenciado bajo Affero GNU Public License version 3.
# Para ver una copia de esta licencia, visite:
# [AGPLv3](https://www.gnu.org/licenses/agpl.md)
#______________________________________________________________________________
#
### __Constantes__
\
readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_DIR=$(dirname "$(realpath "$0")")
!
### __Importar funciones auxiliares__
\
if [[ ! -f "${SCRIPT_DIR}/aux.sh" ]]; then
    RED='\033[31m'    # Rojo para errores
    RESET='\033[0m'   # Reset de color
    echo -e "${RED}Error: Fichero aux.sh no encontrado en ${SCRIPT_DIR}${RESET}" >&2
    exit 1
fi
source "${SCRIPT_DIR}/aux.sh"
!
### __Configuración inicial__
\
cfg_safe_env || {
    echo -e "${RED}Error: No configurarse un entorno seguro.${RESET}" >&2
    exit 1
}
!
#
### __Configuración de variables__
\
FQDN='sobnix.ar'
PKGS=''
UNIT='apache2'
SRV_DIR='/srv/'
USERS_DIR="/home/"
timestamp=$(date +%F_%H.%M.%S)
BACKUP_DIR='/var/local/backups/'
LOG_DIR='/var/log/'
ACCESS_LOG_FILE="${LOG_DIR}${UNIT}-access.log"
ERROR_LOG_FILE="${LOG_DIR}${UNIT}-error.log"
!
### __Instalación de paquetes__
\
echo -e "$CYAN Instalando paquetes ${RESET}"
apt update
apt install -y ${PKGS}
apt distclean
!
### __Respaldo de configuración__
\
echo -e "${CYAN} Respaldando configuración ${RESET}"
CFG_DIR="/etc/apache2/sites-available/"
CFG_FILE="$FQDN.conf"
mkdir -p ${BACKUP_DIR}
if [[ -f ${CFG_DIR}${CFG_FILE} ]]; then
    cp ${CFG_DIR}${CFG_FILE} ${BACKUP_DIR}${CFG_FILE}.${timestamp}
fi
!
### __Modificación de configuración__
\
echo -e "${CYAN} Modificando configuración ${RESET}"
#
if ! grep -q ferorge ${CFG_DIR}${CFG_FILE} ;then
    echo -e "${CYAN} Creando fichero ${RESET}"
    cat <<EOF >> ${CFG_DIR}${CFG_FILE}
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

DocumentRoot $SRV_DIR/

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
EOF
#
chmod 0644 ${CFG_DIR}${CFG_FILE}
fi
!
### __Detención de servicio__
\
echo -e "${CYAN} Deteniendo servicio ${RESET}"
systemctl stop $UNIT
!
### __Activación de módulo__
\
echo -e "${CYAN} Activando módulo ${RESET}"
a2enmod ssl
!
### __Generación de certificados__
\
echo -e "${CYAN} Deteniendo servicio ${RESET}"
certbot certonly --standalone -w $SRV_DIR -d $FQDN
!
### __Activación de sitio__
\
echo -e "${CYAN} Activando sitio ${RESET}"
a2ensite $FQDN
!
### __Inicio de servicio__
\
echo -e "${CYAN} Reiniciando servicio ${RESET}"
systemctl start $UNIT
!
### __Verificación de servicio__
\
echo -e "${CYAN} Verificando servicio ${RESET}"
systemctl status $UNIT
!
