#!/bin/bash

# Instalación de paquetes

## __Autoría y licencia__
###### Instalación de paquetes © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [LPI 102.4_01]:(https://learning.lpi.org/en/learning-materials/101-500/102/102.4/102.4_01/)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Actualización de repositorio__
apt update

## __Instalación de paquetes__
echo -e "$cian Instalando paquetes $default"
apt install -y aptitude screen mc htop iotop ncdu curl nmap

##### Endurecimiento
#apt install -y  acct sysstat auditd audispd-plugins libpam-cracklib haveged debian-goodies debsecan libpam-tmpdir apt-listbugs apt-listchanges needrestart fail2ban aide aide-common ufw clamav arpwatch arpon debsums apt-show-versions unattended-upgrades cfengine3 puppet

## __Limpieza de paquetes__
echo -e "$cian Limpiando paquetes $default"
apt -y clean
apt -y autoclean
apt -y autoremove

## __Búsqueda de fichero__
echo -e "$cian Buscando fichero en los paquetes instalados $default"
dpkg -S iotop

## __Lista de ficheros__
echo -e "$cian Listando ficheros instalados por un paquete $default"
dpkg -L iotop
