#!/usr/bin/env bash

source "${0%/*}"/000.Colores.sh

## __Modificacion de terminal del modo single-user__
sed -i 's/init -t1 S/init S/g' /etc/init.d/single

## __Eliminacion de usuarios__
echo -e "$CYAN Eliminando usuarios $DEFAULT"
deluser --remove-home odroid

## __Adicion de usuarios__
echo -e "$CYAN Adicionando usuarios $DEFAULT"
adduser fernando

## __Modificacion de id__
cp /etc/passwd /var/local/backups/passwd
sed -i 's/1001/1000/g' /etc/passwd
cp /etc/group /var/local/backups/group
sed -i 's/1001/1000/g' /etc/group
chown -R fernando:fernando /home/fernando

## __Verificacion de grupos__
grpck -r

## __Verificacion de passwords__
pwck

## __Modificacion de idioma__
update-locale LANG=es_ES.UTF-8 LANGUAGE
