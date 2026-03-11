#!/usr/bin/env bash

# Respaldo

## __Autoría y licencia__
###### Respaldo © 2026 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [dotlinux]:(www.dotlinux.net/linux-system-administration/the-complete-guide-to-linux-system-backups-and-restores/)

## __Configuración de variables__
timestamp=$(date +%F_%H.%M.%S)
DIR_SRC='/home/'
DIR_DST='/mnt/homes/'

## __Respaldo de incremental de /home__
if grep $DIR_DST /proc/mounts > /dev/null ; then
    rsync -av --exclude=".cache" $DIR_SRC $DIR_DST
else
    logger -p backup.emerg $DIR_DST not mounted

### __Ejecución a las 2 AM__
### Agregar a crontab
### 0 2 * * * /var/local/trisquel-ecne-server/src/680.Respaldo.sh >> /var/log/backup.log 2>&1
