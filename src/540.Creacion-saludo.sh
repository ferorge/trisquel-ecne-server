#!/bin/bash

DIR='/var/local/'
FILE='banner'
FQDN=$(hostname -s)

toilet -s -f ivrit $FQDN > $DIR$FILE
#toilet -W -o -f mini $FQDN >> $DIR$FILE

echo '
--------------------------------------------------
###### Servidor + Publico | Libre > Pubnix

###### Pubnix | Auto alojado > Soberano
--------------------------------------------------

' >> $DIR$FILE

chmod 0664 $DIR$FILE

#T i l d e
#F e d e r a d o
#L i b r e
#S o b e r a n o
