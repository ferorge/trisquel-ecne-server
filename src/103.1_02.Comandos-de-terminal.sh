#!/bin/bash

# Comandos de terminal

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/101-500/103/103.1/103.1_02/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Ver las variables de entorno
echo -e "\n $cian $(apropos -e env) $default"
echo -e "\$ $rojo env $default"

## Ver una linea de texto
echo -e "\n $cian $(apropos echo | head -n1) $default"
echo -e "\$ $rojo echo GNU is not UNIX  $default"

## Establecer variable
echo -e "\n $cian set a variable $default"
echo -e "\$ $rojo myvar=hello  $default"

## Ver variable
echo -e "\n $cian display a variable $default"
echo -e "\$ $rojo echo \$myvar  $default"

## Desestablecer variable
echo -e "\n $cian unset a variable $default"
echo -e "\$ $rojo unset myvar  $default"

## Estableces valores de shell
echo -e "\n $cian $(set --help | grep options | head -n1)  $default"
echo -e "\$ $rojo set myvar  $default"

## Crear fichero
echo -e "\n $cian $(apropos touch | tail -n1)  $default"
echo -e "\$ $rojo touch file  $default"

## Eliminar fichero
echo -e "\n $cian $(apropos rm | grep -e 'remove files')  $default"
echo -e "\$ $rojo rm file  $default"

