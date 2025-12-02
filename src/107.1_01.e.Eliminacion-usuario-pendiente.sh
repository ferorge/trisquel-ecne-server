#!/usr/bin/env bash

# Eliminación de usuario pendiente

## __Autoría y licencia__
###### Eliminación de usuario pendiente © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
USERS=$(cut -d: -f1,3 /etc/shadow | grep :0 | cut -d: -f1)
WD='/var/local/ubuntu-noble-server/src'

## __Cambio de directorio de trabajo__
###### Es necesario cuando el script es ejecutado a través de un enlace
###### simbólico en cron.
cd $WD

## __Importación de colores__
source $WD/000.Colores.sh

## __Modificación de configuración__
logger "$CYAN Eliminando usuarios pendientes $DEFAULT"
for USER in $USERS
do
  deluser -q --remove-home $USER
  rm -fR /var/www/users/$USER
  rm -fR /var/gemini/users/$USER
done
