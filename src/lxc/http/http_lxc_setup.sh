#!/usr/bin/env bash
#
## Configuración de apache2
#
### __Descripción__
#
# Guión para configurar el servidor http.
#
### __Requisitos__
#
#### _Paquetes_
#
# * bash 4.0 o superior
#
### __Uso__
#
#    ./http_lxc_setup.sh
#
### __Autor__
#
# Configuración de apache2 © 2026 por \~ferorge
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
PKGS='apache2 curl certbot'
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
CFG_DIR="/etc/apache2/conf-enabled/"
CFG_FILE="security.conf"
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
ServerTokens Prod
ServerSignature On
TraceEnable Off
EOF
#
chmod 0644 ${CFG_DIR}${CFG_FILE}
fi
!
### __Respaldo de configuración__
\
echo -e "${CYAN} Respaldando configuración ${RESET}"
CFG_DIR="/etc/apache2/mods-enabled/"
CFG_FILE="dir.conf"
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
<IfModule mod_dir.c>
    DirectoryIndex index.html index.py index.php
</IfModule>
EOF
#
chmod 0644 ${CFG_DIR}${CFG_FILE}
fi
!
### __Respaldo de configuración__
\
echo -e "${CYAN} Respaldando configuración ${RESET}"
CFG_DIR="/etc/apache2/conf-available/"
CFG_FILE="cgi-enabled.conf"
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
<Directory $VAR_DIR/html/public>
    Options +ExecCGI
    AddHandler cgi-script .cgi .py
</Directory>

<Directory /home/*/public_html>
    Options +ExecCGI
    AddHandler cgi-script .cgi .py
</Directory>
EOF
#
chmod 0644 ${CFG_DIR}${CFG_FILE}
fi
!
### __Activación de servicio__
\
echo -e "${CYAN} Activando servicio ${RESET}"
systemctl enable $UNIT
!
### __Reinicio de servicio__
\
echo -e "${CYAN} Reiniciando servicio ${RESET}"
systemctl restart $UNIT
!
### __Verificación de servicio__
\
echo -e "${CYAN} Verificando servicio ${RESET}"
systemctl status $UNIT
!
