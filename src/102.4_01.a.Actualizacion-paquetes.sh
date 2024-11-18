#!/bin/bash

# Actualización de paquetes

## __Autoría y licencia__
###### Actualización de paquetes © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [LPI 109.2_01]:(https://learning.lpi.org/en/learning-materials/101-500/102/102.4/102.4_01/)

## __Definición de variables__
WD='/var/local/ubuntu-noble-server/src'

## __Importación de colores__
cd $WD
source $WD/000.Colores.sh

## __Instalación de paquetes__
logger "$CYAN Instalando paquetes $DEFAULT"

##### Actualización de repositorio local
apt-get -qq update

##### Actualiza el sistema instalando y actualizando paquetes.
apt-get -qq -y upgrade

##### Actualiza el sistema desinstalando, instalando y actualizando paquetes.
apt-get -qq -y full-upgrade

##### Elimina los paquetes del repositorio local
apt-get -qq -y clean

##### Elimina los paquetes del repositorio local en desuso.
apt-get -qq -y autoclean

##### Elimina los paquetes instalados como dependencias que están en desuso.
apt-get -qq -y autoremove

#pip3 install --upgrade jupyterhub-nativeauthenticator voila jupyterlab import-ipynb ipycanvas ipywidgets ipyevents



