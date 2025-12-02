#!/usr/bin/env bash

# Comandos de terminal

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/101-500/103/103.2/103.2_01/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Ver o combinar ficheros
echo -e "\n $CYAN $(apropos -e cat | head -n1) $DEFAULT"
echo -e "\$ $RED cat file.txt $DEFAULT"

## Ver 
echo -e "\n $CYAN $(apropos -e bzcat) $DEFAULT"
echo -e "\$ $RED bzcat file   $DEFAULT"

## Ver 
echo -e "\n $CYAN $(apropos -e xzcat) $DEFAULT"
echo -e "\$ $RED xzcat file  $DEFAULT"

## Ver 
echo -e "\n $CYAN $(apropos -e zcat) $DEFAULT"
echo -e "\$ $RED zcat file  $DEFAULT"

## Paginador
echo -e "\n $CYAN $(apropos -e more | grep viewing) $DEFAULT"
echo -e "\$ $RED more file  $DEFAULT"

## Paginador
echo -e "\n $CYAN $(apropos less | grep opposite) $DEFAULT"
echo -e "\$ $RED less file  $DEFAULT"

## Ver 
echo -e "\n $CYAN $(apropos bzless) $DEFAULT"
echo -e "\$ $RED bzless file  $DEFAULT"

## Ver 
echo -e "\n $CYAN $(apropos xzless) $DEFAULT"
echo -e "\$ $RED xzless file  $DEFAULT"

## Ver 
echo -e "\n $CYAN $(apropos zless | tail -n1) $DEFAULT"
echo -e "\$ $RED zless file  $DEFAULT"

## Ver primera parte de fichero
echo -e "\n $CYAN $(apropos -e head | grep first) $DEFAULT"
echo -e "\$ $RED head file  $DEFAULT"

## Ver última parte del fichero
echo -e "\n $CYAN $(apropos -e tail | grep last) $DEFAULT"
echo -e "\$ $RED tail file  $DEFAULT"

## Contar lineas de un fichero
echo -e "\n $CYAN $(apropos -e wc) $DEFAULT"
echo -e "\$ $RED wc file  $DEFAULT"

## Ordenar palabras de un texto.
echo -e "\n $CYAN $(apropos -e sort | grep text) $DEFAULT"
echo -e "\$ $RED sort file $DEFAULT"

## Ver lineas repetidas de un fichero.
echo -e "\n $CYAN $(apropos -e uniq) $DEFAULT"
echo -e "\$ $RED uniq file $DEFAULT"

## Ver un fichero en notación octal.
echo -e "\n $CYAN $(apropos -e od) $DEFAULT"
echo -e "\$ $RED od file $DEFAULT"

## Ver número de lineas de un fichero.
echo -e "\n $CYAN $(apropos -e nl) $DEFAULT"
echo -e "\$ $RED nl file $DEFAULT"

## Ver traducción de un fichero
echo -e "\n $CYAN $(apropos -e tr) $DEFAULT"
echo -e "\$ $RED tr file  $DEFAULT"

## Cortar texto usando delimitadores
echo -e "\n $CYAN $(apropos -e cut | head -n1) $DEFAULT"
echo -e "\$ $RED cut string $DEFAULT"

## Cortar fichero en piezas.
echo -e "\n $CYAN $(apropos -e split | grep pieces) $DEFAULT"
echo -e "\$ $RED split file  $DEFAULT"

## Ver 
echo -e "\n $CYAN $() $DEFAULT"
echo -e "\$ $RED   $DEFAULT"

## Ver 
echo -e "\n $CYAN $() $DEFAULT"
echo -e "\$ $RED   $DEFAULT"

## Ver 
echo -e "\n $CYAN $() $DEFAULT"
echo -e "\$ $RED   $DEFAULT"

## Ver 
echo -e "\n $CYAN $() $DEFAULT"
echo -e "\$ $RED   $DEFAULT"

## Ver 
echo -e "\n $CYAN $() $DEFAULT"
echo -e "\$ $RED   $DEFAULT"

