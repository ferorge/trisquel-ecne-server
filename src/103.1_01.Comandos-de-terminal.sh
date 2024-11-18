#!/bin/bash

# Comandos de terminal

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/101-500/103/103.1/103.1_01

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Ver información del sistema
echo -e "\n $CYAN $(apropos -e uname | grep system) $DEFAULT"
echo -e "\$ $RED uname -a $DEFAULT"

## Ver directorio actual
echo -e "\n $CYAN $(apropos -e pwd) $DEFAULT"
echo -e "\$ $RED pwd $DEFAULT"

## Crear fichero vacío
echo -e "\n $CYAN $(apropos -e touch) $DEFAULT"
echo -e "\$ $RED touch test.txt $DEFAULT"

## Ver contenido del directorio
echo -e "\n $CYAN $(apropos -e ls | grep list) $DEFAULT"
echo -e "\$ $RED ls $DEFAULT"

## Ver manual de la aplicación
echo -e "\n $CYAN $(apropos -e man | grep manual) $DEFAULT"
echo -e "\$ $RED man man $DEFAULT"

## Ver nombre y descripción de los manuales
echo -e "\n $CYAN $(apropos -e apropos) $DEFAULT"
echo -e "\$ $RED apropos apropos $DEFAULT"

## Ver información sobre el tipo de comando.
echo -e "\n $CYAN $(hash --help | grep program) $DEFAULT"
echo -e "\$ $RED hash uname pwd touch ls man apropos hash $DEFAULT"

## Ver las ubicaciones del programa.
echo -e "\n $CYAN $(type --help | grep about) $DEFAULT"
echo -e "\$ $RED type uname pwd touch ls man apropos hash $DEFAULT"

## Ver la ubicación absoluta de un comando.
echo -e "\n $CYAN $(apropos which | head -n1) $DEFAULT"
echo -e "\$ $RED which uname pwd touch ls man apropos hash which $DEFAULT"

## Ver comandos que hayan ejecutado previamente.
echo -e "\n $CYAN $(apropos history | head -n1) $DEFAULT"
echo -e "\$ $RED history 5 $DEFAULT"

