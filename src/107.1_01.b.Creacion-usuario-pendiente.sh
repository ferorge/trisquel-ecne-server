#!/bin/bash

# Creación de usuario pendiente

## __Autoría y licencia__
###### Creación de usuario pendiente © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
WD='/var/local/ubuntu-noble-server/src'

## __Cambio de directorio de trabajo__
cd $WD

## __Importación de colores__
source $WD/000.Colores.sh

while true
do

##### Obtiene el listado de nuevos usuarios pendientes de confirmar contrasña.
file=/home/registro/pendientes.txt
pending_users=$(wc -l < $file)

##### Si encuentra alguno
if [ $pending_users -gt 0 ]
then
  username=$(head -n1 $file | cut -f1 -d:)
  password=$(head -n1 $file | cut -f2 -d:)
  gecos=$(head -n1 $file | cut -f3 -d: | cut -f1 -d',')
  exp_acc=$(date -d "$(date -I) 7 days" -I)

##### Crea el usuario.
  id $username
  if [[ $? != 0 ]];then
    useradd --create-home --comment "$gecos" --gid 100 --shell /bin/bash $username
  fi

###### Otorga permisos minimos para acceder a public_html
  chmod 711 /home/$username

###### Aplica política provisoria de caducidad de cuenta.
  chage -i --mindays 0 --warndays 3 --maxdays 7 --expiredate $exp_acc --inactive 3 $username

###### Aplica contraseña provisoria.
  echo $username:$password | chpasswd

###### Fuerza la expiración de la contraseña para que el usuario indique una propia.
  passwd --expire $username

###### Elimina al nuevo usuario de los pendientes.
  sed -i '1d' $file

##### Reemplaza public_html por enlace simbólico.
  mv /home/$username/public_html /var/www/users/$username
  ln -s /var/www/users/$username /home/$username/public_html

##### Reemplaza public_gemini por enlace simbólico.
  mv /home/$username/public_gemini /var/gemini/users/$username
  ln -s /var/gemini/users/$username /home/$username/public_gemini

##### Incorpora el usuario al index.gmi
  source $WD/602.Modificacion-index.gmi.sh

  logger "El usuario $username fue creado satisfactoriamente."
fi

sleep 5
done &
