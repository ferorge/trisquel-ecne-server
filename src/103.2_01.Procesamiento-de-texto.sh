#!/bin/bash

# Comandos de terminal

## Licencia y autoría
###### Licenciado bajo GPLv3 por ~ferorge <ferorge@texto-plano.xyz>
###### https://www.gnu.org/licenses/gpl.txt

## Fuente
###### https://learning.lpi.org/es/learning-materials/101-500/103/103.2/103.2_01/

## Importación de colores
source "${0%/*}"/000.Colores.sh

## Ver o combinar ficheros
echo -e "\n $cian $(apropos -e cat | head -n1) $default"
echo -e "\$ $rojo cat file.txt $default"

## Ver 
echo -e "\n $cian $(apropos -e bzcat) $default"
echo -e "\$ $rojo bzcat file   $default"

## Ver 
echo -e "\n $cian $(apropos -e xzcat) $default"
echo -e "\$ $rojo xzcat file  $default"

## Ver 
echo -e "\n $cian $(apropos -e zcat) $default"
echo -e "\$ $rojo zcat file  $default"

## Paginador
echo -e "\n $cian $(apropos -e more | grep viewing) $default"
echo -e "\$ $rojo more file  $default"

## Paginador
echo -e "\n $cian $(apropos less | grep opposite) $default"
echo -e "\$ $rojo less file  $default"

## Ver 
echo -e "\n $cian $(apropos bzless) $default"
echo -e "\$ $rojo bzless file  $default"

## Ver 
echo -e "\n $cian $(apropos xzless) $default"
echo -e "\$ $rojo xzless file  $default"

## Ver 
echo -e "\n $cian $(apropos zless | tail -n1) $default"
echo -e "\$ $rojo zless file  $default"

## Ver primera parte de fichero
echo -e "\n $cian $(apropos -e head | grep first) $default"
echo -e "\$ $rojo head file  $default"

## Ver última parte del fichero
echo -e "\n $cian $(apropos -e tail | grep last) $default"
echo -e "\$ $rojo tail file  $default"

## Contar lineas de un fichero
echo -e "\n $cian $(apropos -e wc) $default"
echo -e "\$ $rojo wc file  $default"

## Ordenar palabras de un texto.
echo -e "\n $cian $(apropos -e sort | grep text) $default"
echo -e "\$ $rojo sort file $default"

## Ver lineas repetidas de un fichero.
echo -e "\n $cian $(apropos -e uniq) $default"
echo -e "\$ $rojo uniq file $default"

## Ver un fichero en notación octal.
echo -e "\n $cian $(apropos -e od) $default"
echo -e "\$ $rojo od file $default"

## Ver número de lineas de un fichero.
echo -e "\n $cian $(apropos -e nl) $default"
echo -e "\$ $rojo nl file $default"

## Ver traducción de un fichero
echo -e "\n $cian $(apropos -e tr) $default"
echo -e "\$ $rojo tr file  $default"

## Cortar texto usando delimitadores
echo -e "\n $cian $(apropos -e cut | head -n1) $default"
echo -e "\$ $rojo cut string $default"

## Cortar fichero en piezas.
echo -e "\n $cian $(apropos -e split | grep pieces) $default"
echo -e "\$ $rojo split file  $default"

## Ver 
echo -e "\n $cian $() $default"
echo -e "\$ $rojo   $default"

## Ver 
echo -e "\n $cian $() $default"
echo -e "\$ $rojo   $default"

## Ver 
echo -e "\n $cian $() $default"
echo -e "\$ $rojo   $default"

## Ver 
echo -e "\n $cian $() $default"
echo -e "\$ $rojo   $default"

## Ver 
echo -e "\n $cian $() $default"
echo -e "\$ $rojo   $default"

