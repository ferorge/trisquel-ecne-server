#!/bin/bash

# Crear registro de usuario

## __Autoría y licencia__
###### Crear registro de usuario © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Importación de colores__
source "${0%/*}"/000.Colores.sh

## __Configuración de variables__
UNIT=''
SERVICE="/lib/systemd/system/$UNIT.service"
FQDN=$(hostname -f)
USER=''
VAR_DIR=''
RUN=''
timestamp=$(date +%F_%H.%M.%S)

## __Respaldo de configuración__
echo -e "$cian Respaldando configuración $default"
DIR=''
FILE=''
###### cp $DIR$FILE /var/local/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando configuración $default"
grep ferorge $DIR$FILE
if [[ $? != 0 ]];then
###### echo '
########################
# Editado por ~ferorge #
########################
###### ' >> $DIR$FILE
fi

# Crea una carpeta temporal
TMP_DIR=/tmp/temp
mkdir $TMP_DIR

# Crea usuario para crear usuarios mediante ssh.
useradd --create-home -k $TMP_DIR --comment 'Registro de nuevos usuarios' --shell /home/registro/registro.sh registro

# Copia el shell del usuario.
cp "${0%/*}"/021.Registro.sh /home/registro/registro.sh
chown registro:registro /home/registro/registro.sh

# Elimina la carpeta temporal
rmdir $TMP_DIR

# Establece la contraseña 'Ahora!'
echo registro:'Ahora!' | chpasswd

# El script (es un bucle infinito) se ejectua al iniciar el sistema
echo '/opt/022.Crear-usuario-pendiente.sh' >> /etc/rc.local

# Genera el cron para que elimine usuarios no confirmados.
ln -s /opt/023.Elimiar-usuario-pendiente.sh /etc/cron.daily/Eliminar-usuario-pendiente
