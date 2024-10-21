#!/bin/bash

# Registro de usuario

## __Autoría y licencia__
###### Registro de usuario © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)
CHK_USER='algo'

while [[ -n $CHK_USER ]]
do
  echo -e "$verde"
  read -p "Ingrese el nombre de usuario: " username
  CHK_USER=$(cut -d ':' -f 1 /etc/passwd | grep $username)
  if [[ -n $CHK_USER ]];
  then
    echo -e "$rojo"
    cowsay 'El nombre de usuario no está disponible, por favor elige otro'
    echo ''
  fi
done

echo -e "$rojo"
read -p "Ingrese el nombre real (opcional): " name
echo -e "$verde"
read -p "Ingrese el numero de habitacion (opcional): " room
echo -e "$rojo"
read -p "Ingrese el numero del trabajo (opcional): " work
echo -e "$verde"
read -p "Ingrese el numero de su hogar (opcional): " home
echo -e "$rojo"
read -p "Ingrese su correo electronico (opcional): " Email
password=$(openssl rand -hex 3)

echo -e "$cian
Hola!
Tu peticion de registro fue realizada satisfactoriamente y sera procesada a la brevedad.
Por favor escriba la contraseña temporal de abajo para iniciar sesion por primera vez:
$default"

echo -e "$amarillo"
cowthink $password

echo -e "$verde"
cowsay 'Buena semana'.

echo -e "$default"

echo $username:$password:$name,$room,$work,$home,$Email >> ~/pendientes.txt
