#!/bin/bash

# Creación de textos

## __Autoría y licencia__
###### Creación de textos © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
HOST=$(hostname -s)
timestamp=$(date +%F_%H.%M.%S)
DATE=$(date +%F)
YEAR=$(date +%Y)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/gopher/'
#FILE="*.md"
#cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"

DIV='_______________________________________________'

cat <<EOF > $DIR'_meta.md'
Author: ~ferorge
Date: $DATE
copyright: $YEAR, ~ferorge, CC BY-SA 4.0.
Email: ferorge@texto-plano.xyz
KeyWords: servidor, publico, libre, pubnix, auto alojado, soberano
css: lynx.css
EOF

cat <<EOF > $DIR'_saludo.md'
Bienvenide a sobnix
===================
EOF

toilet -f ivrit -k "    $HOST" > $DIR'_cartel.md'

cat <<EOF > $DIR'_eslogan.md'
  
Servidor + Publico | Libre > Pubnix
  
Pubnix | Auto alojado > Soberano
EOF

fortune rms2 > $DIR'_motd.md'

toilet -f mini -k '  Usuaries' > $DIR'_usuaries.md'

cat <<EOF > $DIR'_licencia.md'
  
__Autoría y licencia__

Documento © 2024 por \~ferorge 
[ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).  
  
!["Licenciado bajo Creative Commons Attribution - Share Alike 4.0 International."][image]
[image]: https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png "CC BY-SA 4.0 International" height=15px width=44px   
  
Para ver una copia de esta licencia, visite [CC BY-SA 4.0].
[CC BY-SA 4.0]:https://creativecommons.org/licenses/by-sa/4.0/deed.es  
EOF

cat <<EOF > $DIR'_pie.md'
$HOST | Pubnix soberano | __En línea desde: $(uptime -s)__
EOF

#vrms |fold -w 64 | sed "2,$ s/^/>  /g" >> $DIR'_vrms.md'
vrms |fold -w 64 | sed "2,$ s/^/>  /g" > $DIR'_vrms.md'

logger "$textos modificados por $USER"

if [ $UID == 0 ]; then
  chown root:staff /var/gopher/_*.md
  chmod 0664 /var/gopher/_*.md
fi

