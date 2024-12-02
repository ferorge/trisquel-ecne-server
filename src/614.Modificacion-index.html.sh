#!/bin/bash

# Modificación de index.html

## __Autoría y licencia__
###### Modificación de index.html © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Configuración de variables__
FQDN=$(hostname -f)
timestamp=$(date +%F_%H.%M.%S)

## __Generación de requisitos previos__
echo -e "$CYAN Generando requisitos previos $DEFAULT"
source "${0%/*}"/540.Creacion-textos.sh
source "${0%/*}"/616.Modificacion-nav.sh
source "${0%/*}"/618.Modificacion-aside.sh

## __Respaldo de configuración__
echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/var/www/html/public/'
FILE='index.html'
META='/var/gopher/_meta.md'
HOME='/var/local/ubuntu-noble-server/doc/site/10.Inicio.md'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$CYAN Modificando configuración $DEFAULT"
DIV='_______________________________________________'

multimarkdown --nolabels -o $DIR$FILE $HOME

cat <<EOF > $DIR$FILE
$(sed -n "0,/<body>/p" $DIR$FILE)
<header>
$(sed -n '/<h1>/p' $DIR$FILE )
$(sed -e "s/^/    /g" /var/gopher/_cartel.md | multimarkdown --nolabels )
$(sed -e "\$a $DIV" -e "1a $DIV" /var/gopher/_eslogan.md | multimarkdown --nolabels )
</header>
<nav>
$(sed -e "\$a $DIV" /var/gopher/_nav.md | multimarkdown --nolabels )
</nav>
<aside>
$(sed -e "\$a $DIV" /var/gopher/_aside.md | multimarkdown --nolabels )
</aside>
<main>
<section>
$(sed '1,/<hr/d;/<h6/,$d' $DIR$FILE)
</section>
</main>
<footer>
$(sed -n "/<h6>/,$ p" $DIR$FILE | sed -n '/<\/body>/q;p')
$(multimarkdown --nolabels /var/gopher/{_pie.md,_vrms.md})
</footer>
$(sed -n "/<\/body>/,$ p" $DIR$FILE)
EOF

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
