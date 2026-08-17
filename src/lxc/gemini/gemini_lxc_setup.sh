#!/usr/bin/env bash
#
## gemini_lxc_setup.sh - Guion para configurar el servidor gemini.
#
### Descripción:
#   (Completar)
#
### Autoría:
# Configuración de molly-brown © 2026 por \~ferorge
# [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
#
### Licencia:
# Licenciado bajo GNU Affero Public License version 3.
# Para ver una copia de esta licencia, visite:
# [AGPLv3]:(https://www.gnu.org/licenses/agpl.md)
# 
### Requisitos:
#* bash 4.0 o superior
#
### Configuración:
#
### Uso:
#   ./gemini_lxc_setup.sh
#
### Comandos durante la ejecución:
#
#_____________________________________________________________________________
#
### Configuración inicial
#
#```bash
set -o errexit   # Salir si un comando falla
set -o nounset   # Error si se usa una variable no definida
set -o pipefail  # Fallar si un comando en un pipe falla
set -o errtrace  # Mejor manejo de errores en funciones/subshells
#```
#_____________________________________________________________________________
#
### Constantes
#```bash
readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_DIR=$(dirname "$(realpath "$0")")

source ${SCRIPT_DIR}/colors.sh
#```
#_____________________________________________________________________________
#
### Importar funciones auxiliares



### Colores

RED='\033[31m'    # Rojo para errores
GREEN='\033[32m'  # Verde para éxitos
CYAN='\033[36m'   # Celeste para configuraciones.
RESET='\033[0m'   # Reset de color

### __Configuración de variables__

FQDN='sobnix.ar'
PKG='molly-brown'
UNIT="${PKG}@${FQDN}"
SRV_DIR='/srv/gemini/'
USERS_DIR="/home/"
timestamp=$(date +%F_%H.%M.%S)
BACKUP_DIR='/var/local/backups/'
CFG_DIR="/etc/${PKG}/"
CFG_FILE="${FQDN}.conf"
LOG_DIR='/var/log/'
ACCESS_LOG_FILE="${LOG_DIR}${PKG}-access.log"
ERROR_LOG_FILE="${LOG_DIR}${PKG}-error.log"

## Instalación de paquetes
echo -e "$CYAN Instalando paquetes ${RESET}"
apt install -y ${PKG}

## __Respaldo de configuración__
echo -e "${CYAN} Respaldando configuración ${RESET}"
mkdir -p ${BACKUP_DIR}
cp ${CFG_DIR}${CFG_FILE} ${BACKUP_DIR}${CFG_FILE}.${timestamp}

## __Modificación de configuración__
echo -e "${CYAN} Modificando configuración ${RESET}"
grep -q ferorge ${CFG_DIR}${CFG_FILE}
if [[ $? != 0 ]];then
    echo -e "${CYAN} Creando fichero ${RESET}"
    cat <<EOF > ${CFG_DIR}${CFG_FILE}

########################
# Editado por ~ferorge #
########################
Hostname = '${FQDN}'
Port = 1965
CertPath = '/etc/letsencrypt/live/${FQDN}/cert.pem'
KeyPath = '/etc/letsencrypt/live/${FQDN}/privkey.pem'
DocBase = '$SRV_DIR'
HomeDocBase = '/home/'
AccessLog = '${ACCESS_LOG_FILE}'
ErrorLog = '${ERROR_LOG_FILE}'
EOF
fi

chmod 0644 ${CFG_DIR}${CFG_FILE}

## __Configuración de registro de enventos__
mkdir -p /var/log/
chmod -R 0775 /var/log/

touch ${ACCESS_LOG_FILE}
chown molly-brown:adm ${ACCESS_LOG_FILE}
chmod 0640 ${ACCESS_LOG_FILE}

touch ${ERROR_LOG_FILE}
chown molly-brown:adm ${ERROR_LOG_FILE}
chmod 0640 ${ERROR_LOG_FILE}

## __Configuración de unit__
sed -i "s/DynamicUser=yes/DynamicUser=no/g" /usr/lib/systemd/system/molly-brown@.service

## __Modificación de index.gmi__
#source "${0%/*}"/602.Modificacion-index.gmi.sh

## __Modificación de esqueleto__
#source "${0%/*}"/107.1_01.skel-gemini.sh

## __Endurecimiento de servicio__
#source "${0%/*}"/endurecimiento/BOOT-5264_${PKG}.sh

## __Configuración de firewall__
#echo -e "${CYAN} Configurando firewall ${RESET}"
#ufw allow 1965/tcp comment $UNIT

## __Activación de servicio__
echo -e "${CYAN} Activando servicio ${RESET}"
systemctl enable $UNIT

## __Reinicio de servicio__
echo -e "${CYAN} Reiniciando servicio ${RESET}"
systemctl restart $UNIT

## __Verificación de servicio__
echo -e "${CYAN} Verificando servicio ${RESET}"
systemctl status $UNIT

## __Verificación de configuración__
#echo -e "${CYAN} Verificando configuración ${RESET}"
