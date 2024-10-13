#!/bin/bash

# Creación de bienvenida

## __Autoría y licencia__
###### Creación de bienvenida © 2024 por \~ferorge
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

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/local/'
FILE='bienvenide.sh'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
echo '#!/bin/bash

########################
# Editado por ~ferorge #
########################

export TIME_ZONE=$(cat /etc/timezone)
export TERM=linux
export TERM=xterm-256color
export LANG=es_ES.UTF-8
export LC_CTYPE=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8
export FQDN=$(hostname -f)
export WIDTH=$(tput cols)

/usr/games/lolcat -f -a -s 200 <<EOF
$(echo -e \\e[2J\\e[\;H)
$(cat /var/gopher/_cartel.md)
_________________________________________________
$(cat /var/gopher/_eslogan.md)
_________________________________________________
$(cat /var/gopher/_motd.md | /usr/games/cowsay -W 47 -f /usr/share/cowsay/cows/eyes.cow)
_________________________________________________
$(vrms | fold -s -w 50)
_________________________________________________

Tiempo en linea: $(uptime -p)
_________________________________________________

Usuarios conectados: $(who -q)

EOF
' > $DIR$FILE

ln -s $DIR$FILE /etc/profile.d/000-$FILE

## __Modificación de permisos__
if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0775 $DIR$FILE
fi
