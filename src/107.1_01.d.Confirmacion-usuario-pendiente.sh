#!/bin/bash

# Confirmación de usuario pendiente

## __Autoría y licencia__
###### Confirmación de usuario pendiente © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
exp_acc=$(date -d "$(date -I) 730 days" -I)
USERS=$(grep '0:7:3:3' /etc/shadow | cut -d: -f1)

## __Modificación de usuarios__
for USER in $USERS
do
  chage -i --maxdays 365 --inactive 180 --expiredate $exp_acc $USER
done

