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
#source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
HOST=$(hostname -s)
timestamp=$(date +%F_%H.%M.%S)
DATE=$(date +%F)
YEAR=$(date +%Y)

## __Respaldo de configuración__
#echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/var/gopher/'
#FILE="*.md"
#cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
#echo -e "$CYAN Modificando configuración $DEFAULT"

DIV='_______________________________________________'

cat <<EOF > $DIR'.00-meta.md'
Language: es
Author: ~ferorge
Email: ferorge@texto-plano.xyz
Affiliation: https://sobnix.dynv6.net
Date: $DATE
copyright: $YEAR, ~ferorge, CC BY-SA 4.0.
KeyWords: servidor, publico, libre, pubnix, auto alojado, soberano
css: lynx.css
Quotes Language: es
Base Header Level: 1
EOF

cat <<EOF > $DIR'.10-header.md'

{{./.11-saludo.md}}
___

{{./.12-cartel.md}}
___

{{./.13-eslogan.md}}
___

EOF

cat <<EOF > $DIR'.11-saludo.md'

Bienvenide a sobnix
===================

EOF

toilet -f ivrit -k "    $HOST" > $DIR'.12-cartel.md'

cat <<EOF > $DIR'.13-eslogan.md'
  
Servidor + Publico | Libre > Pubnix
  
Pubnix | Auto alojado > Soberano
EOF

/usr/games/fortune rms2 > $DIR'_motd.md'

toilet -f mini -k '  Usuaries' > $DIR'_usuaries.md'

cat <<EOF > $DIR'.40-main.md'

<section>
{{./.50-section.md}}
</section>

EOF

cat <<EOF > $DIR'.50-section.md'

## Sección

{{./.60-article.md}}

EOF

cat <<EOF > $DIR'.60-article.md'

### Artículo

EOF

cat <<EOF > $DIR'.70-footer.md'

{{./.71-licencia.md}}
___

{{./.72-pie.md}}
___

{{./.73-vrms.md}}
___

EOF

cat <<EOF > $DIR'.71-licencia.md'
  
#### __Autoría y licencia__

Documento © 2024 por \~ferorge
[ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).

!["Licenciado bajo Creative Commons Attribution - Share Alike 4.0 International."][CC Logo]
[CC Logo]: https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png "CC BY-SA 4.0 International"

Para ver una copia de esta licencia, visite [CC BY-SA 4.0].
[CC BY-SA 4.0]:https://creativecommons.org/licenses/by-sa/4.0/deed.es
EOF

cat <<EOF > $DIR'.72-pie.md'
$HOST | Pubnix soberano | __En línea desde: $(uptime -s)__
EOF

vrms |fold -w 64 | sed "2,$ s/^/>  /g" > $DIR'.73-vrms.md'

logger "textos modificados por $USER"

if [ $UID == 0 ]; then
  chown root:staff /var/gopher/_*.md
  chmod 0664 /var/gopher/_*.md
fi

