#!/bin/bash

# Comandos de terminal

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/101-500/104/104.3/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Ver información del sistema
echo -e "\n $cian $(apropos -e uname | grep system) $default"
echo -e "\$ $rojo uname -a $default"

## Ver directorio actual
echo -e "\n $cian $(apropos -e pwd) $default"
echo -e "\$ $rojo pwd $default"

## Crear fichero vacío
echo -e "\n $cian $(apropos -e touch) $default"
echo -e "\$ $rojo touch test.txt $default"

## Ver contenido del directorio
echo -e "\n $cian $(apropos -e ls | grep list) $default"
echo -e "\$ $rojo ls $default"

## Ver manual de la aplicación
echo -e "\n $cian $(apropos -e man | grep manual) $default"
echo -e "\$ $rojo man man $default"

## Ver nombre y descripción de los manuales
echo -e "\n $cian $(apropos -e apropos) $default"
echo -e "\$ $rojo apropos apropos $default"

## Ver información sobre el tipo de comando.
echo -e "\n $cian $(hash --help | grep program) $default"
echo -e "\$ $rojo hash uname pwd touch ls man apropos hash $default"

## Ver las ubicaciones del programa.
echo -e "\n $cian $(type --help | grep about) $default"
echo -e "\$ $rojo type uname pwd touch ls man apropos hash $default"

## Ver la ubicación absoluta de un comando.
echo -e "\n $cian $(apropos which | head -n1) $default"
echo -e "\$ $rojo which uname pwd touch ls man apropos hash which $default"

## Ver comandos que hayan ejecutado previamente.
echo -e "\n $cian $(apropos history | head -n1) $default"
echo -e "\$ $rojo history 5 $default"

