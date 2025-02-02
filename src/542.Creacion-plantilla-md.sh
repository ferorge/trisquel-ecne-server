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

## __Configuración de variables__
HOST=$(hostname -s)
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
#echo -e "$CYAN Respaldando configuración $DEFAULT"
DIR='/var/gopher/'
FILE="_plantilla.md"
#cp $DIR$FILE /var/local/backups/$FILE.$timestamp

### __Modificación de configuración__
#echo -e "$CYAN Modificando configuración $DEFAULT"

DIV='_______________________________________________'

cat <<EOF > $DIR$FILE
$(cat $DIR'.00-meta.md')
Title: Plantilla

<noscript>Tu navegador no soporta JavaScript, por suerte en este sitio no lo necesitas.</noscript>
<header>
{{./.10-header.md}}
</header>
<nav>
{{./.20-nav.md}}
</nav>
<aside>
{{./.30-aside.md}}
</aside>
<main>
{{./.40-main.md}}
</main>
<footer>
{{./.70-footer.md}}
</footer>

EOF
#$DIV

#Nuevo artículo en $HOST.
#$DIV

#$(cat $DIR'_licencia.md')
#$(echo EOF)

sed -i 's/Documento/Plantilla/g' $DIR$FILE

logger "$FILE modificados por $USER"

if [ $UID == 0 ]; then
  chown root:staff $DIR$FILE
  chmod 0664 $DIR$FILE
fi

