#!/bin/bash

# Eliminación de usuario pendiente

## __Autoría y licencia__
###### Eliminación de usuario pendiente © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
USERS=$(cut -d: -f1,3 /etc/shadow | grep :0 | cut -d: -f1)

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
for USER in $USERS
do
  deluser -q --remove-home $USER
done
