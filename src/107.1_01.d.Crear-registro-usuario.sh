#!/bin/bash

# Crear registro de usuario

## __Autoría y licencia__
###### Crear registro de usuario © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(https://learning.lpi.org/es/learning-materials/102-500/107/107.1/107.1_01/)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
FQDN=$(hostname -f)
USER='registro'
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR='/etc/'
FILE='rc.local'
cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
echo "
########################
# Editado por ~ferorge #
########################
"${0%/*}"/107.1_01.b.Crear-usuario-pendiente.sh" >> $DIR$FILE
fi

## __Crea una carpeta temporal__
TMP_DIR=/tmp/temp
mkdir $TMP_DIR

## __Crea usuario para crear usuarios mediante ssh__
useradd --create-home -k $TMP_DIR --comment 'Registro de nuevos usuarios' --shell /home/$USER/registro.sh $USER

## __Copia el shell del usuario.__
cp "${0%/*}"/107.1_01.a.Registro.sh /home/$USER/registro.sh
chown registro:registro /home/$USER/registro.sh

## __Establece la contraseña 'Ahora!'__
echo $USER:'Ahora!' | chpasswd

## __Genera el cron para que elimine usuarios no confirmados.__
ln -s ""${0%/*}"/107.1_01.c.Elimiar-usuario-pendiente.sh" /etc/cron.daily/Eliminar-usuario-pendiente

## __Elimina la carpeta temporal__
rmdir $TMP_DIR
