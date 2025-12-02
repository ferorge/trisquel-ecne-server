#!/usr/bin/env bash

# Comandos de terminal

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/101-500/103/103.1/103.1_02/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Ver las variables de entorno
echo -e "\n $CYAN $(apropos -e env) $DEFAULT"
echo -e "\$ $RED env $DEFAULT"

## Ver una linea de texto
echo -e "\n $CYAN $(apropos echo | head -n1) $DEFAULT"
echo -e "\$ $RED echo GNU is not UNIX  $DEFAULT"

## Establecer variable
echo -e "\n $CYAN set a variable $DEFAULT"
echo -e "\$ $RED myvar=hello  $DEFAULT"

## Ver variable
echo -e "\n $CYAN display a variable $DEFAULT"
echo -e "\$ $RED echo \$myvar  $DEFAULT"

## Desestablecer variable
echo -e "\n $CYAN unset a variable $DEFAULT"
echo -e "\$ $RED unset myvar  $DEFAULT"

## Estableces valores de shell
echo -e "\n $CYAN $(set --help | grep options | head -n1)  $DEFAULT"
echo -e "\$ $RED set myvar  $DEFAULT"

## Crear fichero
echo -e "\n $CYAN $(apropos touch | tail -n1)  $DEFAULT"
echo -e "\$ $RED touch file  $DEFAULT"

## Eliminar fichero
echo -e "\n $CYAN $(apropos rm | grep -e 'remove files')  $DEFAULT"
echo -e "\$ $RED rm file  $DEFAULT"

