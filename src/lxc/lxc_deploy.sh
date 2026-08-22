#!/usr/bin/env bash
#
## Despliegue de lxc
#
### __Descripción__
#
# Guión para el despliegue de un contenedor LXC con configuración de red, NFS
# y firewall, apto para CI/CD e IaC.
#
### __Requisitos__
#
#### _Paquetes_
#
# * lxc
# * nftables
# * nfs-kernel-server
#
#### _Contenedores_
#
# * Contenedor base (ej: debianForky).
#
#### _Variables de entorno_
#
# LXC_BASE: Nombre del contenedor base (default: debianForky).
# LXC_IP:   IP estática para el contenedor (default: 10.0.3.5).
# LXC_PORT: Puerto a exponer (default: 1965).
# LXC_WD:   Directorio de trabajo de LXC (default: /var/lib/lxc/).
#
### __Uso__
#
#    ./lxc_deploy.sh [NOMBRE_CONTENEDOR]
#
### __Autor__
#
# Despliegue de lxc © 2026 por \~ferorge
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
### __Procesar el fichero de configuración__
\
readonly CFG_FILE=$1

parse_config_file "${CFG_FILE}" || {
    echo -e "${RED}Error: No se pudo procesar ${CFG_FILE}${RESET}" >&2
    exit 1
}
!
#### _Contenedor_
\
LXC_NAME="${LXC_NAME}"                # Nombre del contenedor
LXC_BASE="${LXC_BASE}"                # Contenedor base
LXC_MAC="${LXC_MAC}"                  # MAC address
LXC_IP="${LXC_IP}"                    # IP estática
LXC_PORT="${LXC_PORT}"                # Puerto a exponer
LXC_CMT="${LXC_CMT}"                  # Comentario en cortafuegos
LXC_USER="${LXC_USER}"                # Nombre de usuario
LXC_UID="${LXC_UID}"                  # Id de usuario
LXC_GID="${LXC_GID}"                  # Id de grupo
LXC_DIR="/var/nfs/${LXC_NAME}/"       # Directorio NFS
LXC_SRV_DIR="/srv/lxc/${LXC_NAME}/"   # Directorio de servicio
LXC_OPT_DIR="/opt/lxc/${LXC_NAME}/"   # Directorio de configuración

LXC_WD="/var/lib/lxc/"                # Directorio de trabajo LXC
LXC_NET="/etc/dnsmasq.d/lxc.conf"     # Configuración de red
NFS_EXPORT="/etc/exports"             # Archivo de exports NFS

DOMAIN="sobnix.ar"
!
### __Creación de directorios__
#
create_directories() {
    local DIRS="${LXC_DIR} ${LXC_OPT_DIR} ${LXC_SRV_DIR}"
    for dir in $DIRS; do
	if [ ! -d "$dir" ]; then
            mkdir -p ${user_dir}
            echo -e "${GREEN}OK: Directorio $user_dir creado. ${RESET}"
	fi
    done
}
### __Verificación de entorno__
#
# Comprueba que las herramientas y recursos necesarios están disponibles.
\
validate_environment() {
    command -v lxc-stop >/dev/null || { \
        echo -e "${RED}Error: lxc-stop no está instalado${RESET}"; \
        exit 1; \
    }
    command -v lxc-copy >/dev/null || { \
        echo -e "${RED}Error: lxc-copy no está instalado${RESET}"; \
        exit 1; \
    }
    lxc-ls | grep -qw "$LXC_BASE" || { \
        echo -e "${RED}Error: Contenedor base $LXC_BASE no existe${RESET}"; \
        exit 1; \
    }
    command -v nft >/dev/null || { \
        echo -e "${RED}Error: nftables no está instalado${RESET}"; \
        exit 1; \
    }
    [ -d "$LXC_WD" ] || { \
        echo -e "${RED}Error: $LXC_WD no existe${RESET}"; \
        exit 1; \
    }
    [ -d "$LXC_DIR" ] || { \
        echo -e "${RED}Error: $LXC_DIR no existe${RESET}"; \
        exit 1; \
    }
    [ -d "$LXC_OPT_DIR" ] || { \
        echo -e "${RED}Error: $LXC_OPT_DIR no existe${RESET}"; \
        exit 1; \
    }
    [ -d "$LXC_SRV_DIR" ] || { \
        echo -e "${RED}Error: $LXC_SRV_DIR no existe${RESET}"; \
        exit 1; \
    }
    ping -c 1 "$LXC_IP" >/dev/null 2>&1 && { \
        echo -e "${RED}Error: IP $LXC_IP ya está en uso${RESET}"; \
        exit 1; \
    }
    echo -e "${GREEN}OK: Entorno validado.${RESET}"
}
!
### __Creación del usuario__
#
# Crea el usuario solo si no existe.
\
create_user() {
    if id "${LXC_USER}" &>/dev/null; then
        echo -e "${GREEN}OK: Usuario ${LXC_USER} ya existe.${RESET}"
    else
        echo -e "${CYAN}Creando usuario $LXC_USER con UID $LXC_UID...${RESET}"
        useradd -u ${LXC_UID} -U -g ${LXC_GID} -M -s /usr/sbin/nologin ${LXC_USER} || {
            echo -e "${RED}Error: No se pudo crear el usuario ${LXC_USER}${RESET}"
            exit 1
        }
        echo -e "${GREEN}OK: Usuario ${LXC_USER} creado con UID $LXC_UID.${RESET}"
    fi
}
!
### __Creación del contenedor__
#
# Crea el contenedor solo si no existe.
\
create_container() {
    if ! lxc-ls | grep -qw "$LXC_NAME"; then
	echo -e "${CYAN}Creando contenedor $LXC_NAME desde $LXC_BASE...${RESET}"

	# Verificar si LXC_BASE existe
	if ! lxc-ls | grep -qw "$LXC_BASE"; then
	    echo -e "${RED}Error: El contenedor base $LXC_BASE no existe.${RESET}"
	    exit 1
	fi

	# Verificar si LXC_BASE está en ejecución
	if lxc-info -n "$LXC_BASE" -s | grep -q "RUNNING"; then
	    echo -e "${YELLOW}Deteniendo $LXC_BASE temporalmente...${RESET}"
	    if ! lxc-stop -n "$LXC_BASE" -t 30; then
		echo -e "${RED}Error: No se pudo detener $LXC_BASE.${RESET}"
		exit 1
	    fi

	    echo -e "${CYAN}Copiando contenedor...${RESET}"
	    if ! lxc-copy -n "$LXC_BASE" -N "$LXC_NAME"; then
		echo -e "${RED}Error: Falló la copia de $LXC_BASE a $LXC_NAME.${RESET}"
		# Intentar reiniciar LXC_BASE antes de salir
		lxc-start -n "$LXC_BASE" || echo -e "${YELLOW}Advertencia: No se pudo reiniciar $LXC_BASE.${RESET}"
		exit 1
	    fi

	    echo -e "${YELLOW}Reiniciando $LXC_BASE...${RESET}"
	    if ! lxc-start -n "$LXC_BASE"; then
		echo -e "${RED}Error: No se pudo reiniciar $LXC_BASE.${RESET}"
		exit 1
	    fi
	else
	    echo -e "${CYAN}Copiando contenedor...${RESET}"
	    if ! lxc-copy -n "$LXC_BASE" -N "$LXC_NAME"; then
		echo -e "${RED}Error: Falló la copia de $LXC_BASE a $LXC_NAME.${RESET}"
		exit 1
	    fi
	fi
    else
	echo -e "${GREEN}OK: Contenedor $LXC_NAME ya existe.${RESET}"
    fi
}
!
### __Configuración de red__
#
# Asigna nombre de hosts
\
configure_hosts() {
    echo ${LXC_IP}  ${LXC_NAME}.${DOMAIN} ${LXC_NAME} >> \
	 ${LXC_WD}${LXC_NAME}/rootfs/etc/hosts
    
    if ! grep -qF "${LXC_NAME}.${DOMAIN}" /etc/hosts; then
        echo -e "${CYAN}Configurando nombre de host $LXC_NAME" \
            "($LXC_IP)...${RESET}"
	echo ${LXC_IP}  ${LXC_NAME}.${DOMAIN} ${LXC_NAME} >> \
	       /etc/hosts
    else
        echo -e "${GREEN}OK: Asignación DHCP ya existe.${RESET}"
    fi
}
!
# Asigna liberación estática al servidor DHCP
\
configure_dhcp() {
    if ! grep -qF "$LXC_NAME,$LXC_IP" "$LXC_NET"; then
        echo -e "${CYAN}Configurando asignación DHCP para $LXC_NAME" \
            "($LXC_IP)...${RESET}"
        echo "dhcp-host=$LXC_MAC,$LXC_IP" >> "$LXC_NET"
        systemctl restart lxc-net
    else
        echo -e "${GREEN}OK: Asignación DHCP ya existe.${RESET}"
    fi
}
!
### __Creación de directorio__
#
# Configura el directorio NFS y su export.
\
configure_nfs() {
    mkdir -p "$LXC_DIR"
    chown root:root "$LXC_DIR"
    chmod 0755 "$LXC_DIR"

    # --- Configuración de directorios para usuarios con UID 100 ---
    echo -e "${CYAN}Configurando directorios de usuarios en $LXC_DIR...${RESET}"
    local CURRENT_USERS
    CURRENT_USERS=$(awk -F: '$4 == 100 && $1 != "x"' /etc/passwd | cut -d: -f1)

    for user in $CURRENT_USERS; do
        local user_dir="$LXC_DIR${user}"
        local public_link="/home/${user}/public_${LXC_NAME}"

        # Crear directorio si no existe
        if [ ! -e "$user_dir" ]; then
            mkdir -p "$user_dir"
            echo -e "${CYAN}Creado directorio $user_dir${RESET}"
        fi

        # Si public_link existe y NO es un enlace simbólico, moverlo
        if [ -e "$public_link" ] && [ ! -L "$public_link" ]; then
            echo -e "${CYAN}Moviendo $public_link a $user_dir${RESET}"
            mv "$public_link" "$user_dir"
        fi

        # Crear enlace simbólico si no existe
        if [ ! -L "$public_link" ]; then
            echo -e "${CYAN}Creando enlace simbólico $public_link -> $user_dir${RESET}"
            ln -s "$user_dir" "$public_link"
        fi

        # Asegurar permisos correctos
        if [ -d "$user_dir" ]; then
            chown -R "$user:users" "$user_dir"
            echo -e "${GREEN}OK: Permisos configurados para $user_dir${RESET}"
        fi
    done

    local export_entry="$LXC_DIR $LXC_IP(rw,no_subtree_check,root_squash,fsid=0)"
    if ! grep -qF "$export_entry" "$NFS_EXPORT"; then
        echo -e "${CYAN}Configurando NFS para $LXC_DIR...${RESET}"
        echo "$export_entry" >> "$NFS_EXPORT"
        systemctl restart nfs-kernel-server
    else
        echo -e "${GREEN}OK: Export NFS ya existe.${RESET}"
    fi
}
!
### __Configuración del contenedor__
#
# Escribe la configuración del contenedor.
\
configure_container() {
    local config_file="${LXC_WD}${LXC_NAME}/config"
    echo -e "${CYAN}Configurando $config_file...${RESET}"
    cat <<EOF >> "$config_file"
lxc.start.auto = 1
lxc.mount.entry = /etc/passwd \
${LXC_WD}${LXC_NAME}/rootfs/etc/passwd none bind,ro 0 0
lxc.mount.entry = /etc/shadow \
${LXC_WD}${LXC_NAME}/rootfs/etc/shadow none bind,ro 0 0
lxc.mount.entry = /etc/group \
${LXC_WD}${LXC_NAME}/rootfs/etc/group none bind,ro 0 0
lxc.mount.entry = /etc/gshadow \
${LXC_WD}${LXC_NAME}/rootfs/etc/gshadow none bind,ro 0 0
lxc.mount.entry = /etc/letsencrypt/ \
${LXC_WD}${LXC_NAME}/rootfs/etc/letsencrypt/ none bind,ro 0 0
lxc.mount.entry = ${LXC_DIR} \
${LXC_WD}${LXC_NAME}/rootfs/home/ none bind,ro 0 0
lxc.mount.entry = ${LXC_SRV_DIR} \
${LXC_WD}${LXC_NAME}/rootfs/srv/ none bind,ro 0 0
lxc.mount.entry = ${LXC_OPT_DIR} \
${LXC_WD}${LXC_NAME}/rootfs/opt/ none bind,ro 0 0
EOF
    mkdir -p ${LXC_WD}${LXC_NAME}/rootfs/etc/letsencrypt/
    mkdir -p ${LXC_WD}${LXC_NAME}/rootfs/home/
    mkdir -p ${LXC_WD}${LXC_NAME}/rootfs/opt/
    mkdir -p ${LXC_WD}${LXC_NAME}/rootfs/srv/

    chmod 0755 ${LXC_WD}${LXC_NAME}/rootfs/home/
    chmod 0755 ${LXC_WD}${LXC_NAME}/rootfs/opt/
    chmod 0755 ${LXC_WD}${LXC_NAME}/rootfs/srv/

}
!
### __Configuración de cortafuegos con nftables__
#
# Abre el puerto en host y desvia al contenedor
\
configure_firewall() {
    if ! nft list ruleset | grep -q "dport $LXC_PORT.*comment.*$LXC_CMT"; then
        echo -e "${CYAN}Configurando cortafuegos para puerto $LXC_PORT...${RESET}"
        nft add rule inet filter TCP tcp dport "$LXC_PORT" \
            accept comment "$LXC_CMT"
        nft add rule ip nat prerouting tcp dport "$LXC_PORT" \
            dnat to "$LXC_IP:$LXC_PORT"
    else
        echo -e "${GREEN}OK: Reglas de cortafuegos ya existen.${RESET}"
    fi
}

## Iniciación del contenedor si no está en ejecución.
start_container() {
    if ! lxc-info -n "$LXC_NAME" | grep -q "RUNNING"; then
        echo -e "${CYAN}Iniciando contenedor $LXC_NAME...${RESET}"
        lxc-start -n "$LXC_NAME"
    else
        echo -e "${GREEN}OK: Contenedor $LXC_NAME ya está en ejecución.${RESET}"
    fi
}
!
### __Iniciación del contenedor al inicio del sistema.__
\
auto_start_container() {
    local config_file="${LXC_WD}${LXC_NAME}/config"
    if grep -qF "lxc.start.auto = 1" "$config_file"; then
        echo -e "${CYAN}Configurando inicio automático para $LXC_NAME...${RESET}"
        systemctl enable lxc@${LXC_NAME}
    fi
}
!
### __Configuración del servicio dentro del contenedor.__
\
configure_service() {
    lxc-attach -n ${LXC_NAME} -- /opt/${LXC_NAME}_lxc_setup.sh
}
!
### __Reversión__
#
# Elimina todos los recursos creados en caso de error.
\
cleanup() {
    echo -e "${RED}Advertencia: Limpieza por error...${RESET}"
    declare -p | grep LXC_
    lxc-stop -n "$LXC_NAME" 2>/dev/null || true
    lxc-destroy -n "$LXC_NAME" 2>/dev/null || true
    sed -i "/$LXC_NAME,$LXC_IP/d" "$LXC_NET" 2>/dev/null || true
    sed -i "/$LXC_DIR.*$LXC_IP/d" "$NFS_EXPORT" 2>/dev/null || true
    nft flush ruleset 2>/dev/null || true
    systemctl restart lxc-net nfs-kernel-server 2>/dev/null || true
    #userdel ${LXC_USER} 2>/dev/null || true
}
trap cleanup ERR
!
### __Ejecución principal__
\
main() {
    create_directories
    validate_environment
    create_user
    create_container
    configure_hosts
    configure_dhcp
    configure_nfs
    configure_container
    auto_start_container
    configure_firewall
    start_container
    configure_service
    echo -e "${GREEN}OK: Despliegue completado para $LXC_NAME${RESET}"
}

main "$@"
\
