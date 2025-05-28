#!/bin/bash

# Instalación de kernel linux-libre

## __Autoría y licencia__
###### Instalación de kernel linux-libre © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [FSFLA]:(https://www.fsfla.org/ikiwiki/selibre/linux-libre/freesh.es.html)

## __Instalación de paquetes__
echo -e "$CYAN Instalando paquetes $DEFAULT"

###### Descarga de llaves
wget https://linux-libre.fsfla.org/pub/linux-libre/freesh/pool/main/f/freesh-archive-keyring/freesh-archive-keyring_1.1_all.deb

###### Instalación de llaves
dpkg -i freesh-archive-keyring_1.1_all.deb

###### Eliminación de llaves
rm freesh-archive-keyring_1.1_all.deb

###### Actualización de repositorios
apt update

###### Instalación de paquete
apt install -y linux-libre-lts
