#!/bin/bash

# Creación de textos

## __Autoría y licencia__
###### Creación de textos © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
HOST=$(hostname -s)
FQDN=$(hostname -f)
timestamp=$(date +%F_%H.%M.%S)
DATE=$(date +%F)
YEAR=$(date +%Y)

## __Respaldo de configuración__
logger '540 | Respaldando configuración.'
DIR='/var/gopher/es/'
#FILE="*.md"
#cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
logger '540 | Modificando configuración.'

DIV='_______________________________________________'

cat <<EOF > $DIR'.01-head.mmd'
Language: es
Author: ~ferorge
Email: ferorge@texto-plano.xyz
Affiliation: https://$FQDN
Date: $DATE
copyright: $YEAR, ~ferorge, CC BY-SA 4.0.
KeyWords: servidor, publico, libre, pubnix, auto alojado, soberano
css: lynx.css
Quotes Language: es
Base Header Level: 1
EOF

cat <<EOF > $DIR'.10-header.mmd'

{{./12-cartel.md}}
___

{{./13-eslogan.md}}
___

EOF

cat <<EOF > $DIR'11-saludo.md'

Bienvenide
==========

EOF

toilet -f ivrit -k "       $HOST" > $DIR'12-cartel.md'

cat <<EOF > $DIR'13-eslogan.md'
  
Servidor + Publico | Libre > Pubnix
  
Pubnix | Auto alojado > Soberano
EOF

cat <<EOF > $DIR'.40-main.mmd'

<section>
{{./.50-section.mmd}}
</section>

EOF

cat <<EOF > $DIR'.50-section.mmd'

{{./60-article.md}}

EOF

cat <<EOF > $DIR'60-article.md'

### Artículo

EOF

/usr/games/fortune rms2 > $DIR'61-motd.md'

toilet -f mini -k '    Usuaries' > $DIR'62-usuaries.md'

cat <<EOF > $DIR'63-userlist.md'
$(grep ':100:' /etc/passwd | grep -v ':x:100:' | cut -d ':' -f 1 | sort | xargs -I {} printf "[~{}](https://$FQDN/~{}/)  \n")
EOF

cat <<EOF > $DIR'.70-footer.mmd'

{{./72-pie.md}}
___

{{./73-vrms.md}}
___

$(echo EOF)
EOF

cat <<EOF > $DIR'71-licencia.md'
  
#### __Autoría y licencia__

Documento © $YEAR por \~ferorge
[ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).

!["Licenciado bajo Creative Commons Attribution - Share Alike 4.0 International."][CC Logo]
[CC Logo]: https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png "CC BY-SA 4.0 International"

Para ver una copia de esta licencia, visite [CC BY-SA 4.0].
[CC BY-SA 4.0]:https://creativecommons.org/licenses/by-sa/4.0/deed.es
EOF

cat <<EOF > $DIR'72-pie.md'
$HOST | Pubnix soberano | __En línea desde: $(uptime -s)__
EOF

vrms |fold -w 64 | sed "2,$ s/^/>  /g" > $DIR'73-vrms.md'

logger "textos modificados por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR*.md
  chmod 0664 $DIR*.md
fi
