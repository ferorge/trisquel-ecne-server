#!/usr/bin/env bash

## --- Constantes ---
readonly AUX_NAME=$(basename "$0")
readonly AUX_DIR=$(dirname "$(realpath "$0")")

source ${AUX_DIR}/colors.sh

# Función para activar las opciones de Bash que mejoran la detección de errores y la robustez del script
cfg_safe_env() {
    set -o errexit   # Finaliza si cualquier comando devuelve un código de error no cero.
    set -o nounset   # Finaliza si se intenta usar una variable no definida.
    set -o pipefail  # Asegura que el código de salida de un pipeline sea el del último comando que falló.
    set -o errtrace  # Permite que los errores en funciones, subshells y comandos en pipelines sean capturados.
}

# Función para procesar un archivo .cfg y cargar las variables en el entorno actual
# Uso: parse_config_file "ruta/al/archivo.cfg"
parse_config_file() {
    local config_file="$1"

    # Verificar que el archivo existe y es legible
    if [[ ! -f "$config_file" ]]; then
	echo -e "${RED}Error: El archivo de configuración '$config_file' no existe.${RESET}" >&2
	return 1
    fi

    if [[ ! -r "$config_file" ]]; then
	echo -e "${RED}Error: No se puede leer el archivo '$config_file'.${RESET}" >&2
	return 1
    fi

    # Leer el archivo línea por línea
    while IFS= read -r line || [[ -n "$line" ]]; do
	# Ignorar líneas vacías y comentarios (empezando con #)
	[[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

	# Eliminar espacios alrededor del signo =
	line="${line// /}"  # Elimina todos los espacios 
	line="${line/ =/=}"  # Elimina espacio antes de =
	line="${line/= /=}"  # Elimina espacio después de =

	# Dividir la línea en clave y valor (usando = como separador)
	if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
	    local clave="${BASH_REMATCH[1]}"
	    local valor="${BASH_REMATCH[2]}"

	    # Eliminar comillas simples o dobles si existen (opcional)
	    valor="${valor%\"}"  # Elimina comilla doble al final
	    valor="${valor#\"}"  # Elimina comilla doble al inicio
	    valor="${valor%\'}"  # Elimina comilla simple al final
	    valor="${valor#\'}"  # Elimina comilla simple al inicio

	    # Asignar el valor a una variable con el nombre de la clave
	    declare -g "$clave"="$valor"
	else
	    echo "Advertencia: Línea mal formada en '$config_file': '$line'" >&2
	fi
    done < "$config_file"

    return 0
    }

check_dependencies() {
    local missing_deps=()
    for cmd in "$@"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo -e "${RED}Error: Los siguientes comandos no están instalados:${RESET}" >&2
        for cmd in "${missing_deps[@]}"; do
            echo -e "  - ${cmd}" >&2
        done
        exit 1
    fi
}

set_pager() {
    # Verificar si PAGER ya está definido y no está vacío
    if [[ -z "${PAGER}" ]]; then
        echo "${YELLOW}La variable PAGER no está configurada.${RESET}"

        # Lista de paginadores a buscar (en orden de preferencia)
        local pagers=("bat -p" "batcat -p" "most" "less" "more")
        local available_pagers=()
        local available_pager_commands=()  # Para almacenar los comandos sin argumentos

        # Buscar paginadores disponibles en el sistema
        for pager in "${pagers[@]}"; do
            # Extraer el comando base (sin argumentos)
            local pager_cmd=$(echo "$pager" | awk '{print $1}')
            if command -v "$pager_cmd" &> /dev/null; then
                available_pagers+=("$pager")
                available_pager_commands+=("$pager_cmd")
            fi
        done

        # Si no hay paginadores disponibles, mostrar error y salir
        if [[ ${#available_pagers[@]} -eq 0 ]]; then
            echo -e "${RED}Error: No se encontraron paginadores instalados (bat, batcat, most, less, more).${RESET}"
            return 1
        fi

        # Mostrar opciones disponibles al usuario
        echo -e "${CYAN}Paginadores disponibles:${RESET}"
        for ((i=0; i<${#available_pagers[@]}; i++)); do
            echo -e "${YELLOW}  $((i+1)). ${CYAN}${available_pagers[i]}${RESET}"
        done

        # Solicitar elección al usuario
        local choice
        while true; do
            read -p "Elige un paginador (1-${#available_pagers[@]}): " choice
            if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#available_pagers[@]} )); then
                break
            else
                echo -e "${RED}Error: Opción no válida. Intenta de nuevo.${RESET}"
            fi
        done

        # Asignar el paginador elegido a PAGER
        local selected_pager="${available_pagers[$((choice-1))]}"
        export PAGER="$selected_pager"
        echo -e "${GREEN}PAGER configurado a: $PAGER${RESET}"
    else
        echo -e "${GREEN}PAGER ya está configurado a: $PAGER${RESET}"
    fi
}
