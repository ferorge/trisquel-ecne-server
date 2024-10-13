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

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
FQDN=$(hostname -f)
timestamp=$(date +%F_%H.%M.%S)

## __Generación de requisitos previos__
echo -e "$cian Generando requisitos previos $default"
source "${0%/*}"/540.Creacion-textos.sh

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/var/www/html/public/'
FILE='index.html'
META='/var/gopher/_meta.md'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
DIV='_______________________________________________'

echo "Title: $(head -n1 /var/gopher/_saludo.md)" >> $META
multimarkdown --nolabels -o $DIR$FILE $META

#$(multimarkdown --nolabels /var/gopher/_nav.md)
cat <<EOF > $DIR$FILE
$(sed -n "0,/<body>/p" $DIR$FILE)
<header>
$(multimarkdown --nolabels /var/gopher/_saludo.md)
$(sed -e "s/^/    /g" /var/gopher/_cartel.md | multimarkdown --nolabels )
$(sed -e "\$a $DIV" -e "1a $DIV" /var/gopher/_eslogan.md | multimarkdown --nolabels )
</header>
<nav>
</nav>
<aside>
$(sed -e "\$a $DIV" /var/gopher/_aside.md | multimarkdown --nolabels )
</aside>
<main>
<section>
$(multimarkdown --nolabels /var/gopher/_motd.md)
</section>
</main>
<footer>
$(sed -e "\$a $DIV" -e "1a $DIV \n" -e 's/__Autoría/##### __Autoría/' /var/gopher/_licencia.md | multimarkdown --nolabels )
$(multimarkdown --nolabels /var/gopher/{_pie.md,_vrms.md})
</footer>
$(sed -n "/<\/body>/,$ p" $DIR$FILE)
EOF

logger "$FILE modificado por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi
