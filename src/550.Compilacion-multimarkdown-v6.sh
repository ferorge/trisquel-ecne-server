#!/bin/bash

# Compilar multimarkdown v6

## __Autoría y licencia__
###### Compilar multimarkdown v6 © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [Multimarkdown v6]:(https://github.com/fletcher/MultiMarkdown-6/)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## Instalación de paquetes
echo -e "$CYAN Instalando paquetes $DEFAULT"

##### Descargar codigo fuente.
mkdir /opt/mmd6
cd /opt/mmd6
wget https://github.com/fletcher/MultiMarkdown-6/archive/refs/tags/6.7.0.tar.gz

##### Compilar codigo fuente
tar xvfz ./6.7.0.tar.gz MultiMarkdown-6-6.7.0/
cd MultiMarkdown-6-6.7.0/
make release
cd build/
make

##### Instalar aplicación
mv ./multimarkdown /usr/local/bin/multimarkdown
chmod 755 /usr/local/bin/multimarkdown

##### Limpiar
cd
rm -fR /opt/mmd6
