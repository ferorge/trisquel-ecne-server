#!/bin/bash

source /opt/000.Colores.sh
alias ~~~=echo

# Modificacion de terminal del modo single-user
sed -i 's/init -t1 S/init S/g' /etc/init.d/single

# Eliminacion de usuarios
echo -e "$cian Eliminando usuarios $default"
deluser --remove-home odroid

# Adicion de usuarios
echo -e "$cian Adicionando usuarios $default"
adduser fernando

# Modificacion de id
~~~
cp /etc/passwd /var/backups/passwd
sed -i 's/1001/1000/g' /etc/passwd
cp /etc/group /var/backups/group
sed -i 's/1001/1000/g' /etc/group
chown -R fernando:fernando /home/fernando
~~~

# Verificacion de grupos
grpck -r

# Verificacion de passwords
pwck

# Modificacion de idioma
update-locale LANG=es_ES.UTF-8 LANGUAGE
