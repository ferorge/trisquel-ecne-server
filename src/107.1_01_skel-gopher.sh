#!/bin/bash

# Esqueleto para gopher

## __Autoría y licencia__
###### Esqueleto para gopher © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
FQDN=$(hostname -f)
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/skel/public_gopher/'
FILE='gophermap'
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE

mkdir -p $DIR
chmod 0755 $DIR

cowsay -f pocho 'Bienvenide a mi hoyo gopher libre, público y soberano.' > $DIR$FILE
echo '0Markdown       markdown.md' >> $DIR$FILE
chmod 0644 $DIR$FILE

FILE='markdown.md'

echo '
# Título 1
## Título 2
### Título 3
#### Título 4
##### Título 5
###### Título 6

***

titulo con doble subrayado
==========================


titulo subrayado
----------------

---

> texto citado
>>
>> citado anidado

* lista con asterisco
+ lista con suma
- lista con guion

~~
bloque de codigo.
~~

1. lista numerada con uno.
2. lista numerada con dos.
3. lista numerada con tres.

___

`
code
`
___

    pre

___

_cursiva con guion bajo_

__negrita con doble guion bajo__

___cursiva y negrita con triple guion bajo___

*cursiva con asterisco*

**negrita con doble asteriso**

***cursiva y negrita con triple guion bajo***

`texto entre comilla`

~texto entre tilde~

---

Texto con linea
quebrada.

---

*Simbolos*

* Copyright &copy;
* Registered trademark &reg;
* Trademark &trade;
* Euro &euro;
* Left arrow &larr;
* Up arrow &uarr;
* Right arrow &rarr;
* Down arrow &darr;
* Degree &#176;
* Pi &#960;

---

[sitio](https://sobnix.dynv6.net)

---

enlace con [referencia][sitio]
[sitio]:https://sobnix.dynv6.net

---

![CC-BY](https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by.png "texto entre comillas dobles")

' >> $DIR$FILE
chmod 0644 $DIR$FILE
