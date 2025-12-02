#!/usr/bin/env bash

# Registro de usuario

## __Autoría y licencia__
###### Registro de usuario © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(https://learning.lpi.org/es/learning-materials/102-500/107/107.1/107.1_01/)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)
CHK_USER='algo'
LENGTH=$(shuf -i 1-4 -n 1)
HEAD=$(openssl rand -hex $(( 7 * $LENGTH)) | fold -w 7)
FOOT=$(openssl rand -hex $(( 7 * $LENGTH)) | fold -w 7)

while [[ -n $CHK_USER ]]
do
  echo -e "$GREEN"
  read -p "Ingrese el nombre de usuario: " username
  CHK_USER=$(cut -d ':' -f 1 /etc/passwd | grep $username)
  if [[ -n $CHK_USER ]];
  then
    echo -e "$RED"
    cowsay 'El nombre de usuario no está disponible, por favor elige otro'
    echo ''
  fi
done

echo -e "$RED"
read -p "Ingrese el nombre real (opcional): " name
echo -e "$GREEN"
read -p "Ingrese el numero de habitacion (opcional): " room
echo -e "$RED"
read -p "Ingrese el numero del trabajo (opcional): " work
echo -e "$GREEN"
read -p "Ingrese el numero de su hogar (opcional): " home
echo -e "$RED"
read -p "Ingrese su correo electronico (opcional): " Email
password=$(openssl rand -hex $(( 7 * $LENGTH)) | fold -w 7 | shuf -n 1)
echo -e "$GREEN
Hola!
Tu peticion de registro fue realizada satisfactoriamente y sera procesada a la brevedad.
Por favor escriba la contraseña temporal marcada en otro color para iniciar sesion por primera vez:"

echo -e "
$MAGENTA$HEAD
$YELLOW$password
$MAGENTA$FOOT
$DEFAULT
EOF"

echo $username:$password:$name,$room,$work,$home,$Email >> ~/pendientes.txt
