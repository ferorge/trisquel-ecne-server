#!/bin/bash

# Endurecimiento BANN-7130

## __Autoría y licencia__
###### Endurecimiento BANN-7130 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [BANN-7130]:(https://linux-audit.com/the-real-purpose-of-login-banners-on-linux/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='BANN-7130'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# PKG=''
# apt install -y $PKG

## __Respaldo de configuración__
DIR='/etc/'
FILE='issue.net'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
cat <<EOF > $DIR$FILE
# Security policy

-------------------------------------------------------------------------------
##### _Important Safety Notice_

-------------------------------------------------------------------------------
- For the safety of users, this public Linux server is subject to strict  
policies and security measures designed to protect your data and ensure legal  
and legislative compliance.
- The scope includes all linked computers and access to Internet.  
- Only authorized users can access this server. 
- You must obtain explicit consent from the administrator before try to connect  
to this server. 
- Any unauthorized use of this system is prohibited and may considered an  
illegal act. 
- Any evidence of intrusion, criminal act, unauthorized access or attempt to  
circumvent security measures may be penalized.

-------------------------------------------------------------------------------
__warning: by logging into this system, you acknowledge and accepts the__  
__monitoring and recording of activities.__

-------------------------------------------------------------------------------
The monitoring and recording of activities is continuous and is carried out  
solely for the purpose of auditing and guaranteeing the security of our users  
and systems.
It is not used for espionage, monitoring or any other purpose to the afore  
mentioned.

-------------------------------------------------------------------------------
##### _Privacy and data protection_

-------------------------------------------------------------------------------
- The users and administrators of this server undertake to enforce security  
policy and laws and regulations applicable, protecting privacy and guaranteeing  
the confidentiality of the data of all users.
- The data is private, its use is restricted and each user is owner of his.
- Data is stored securely and unauthorized access is forbidden.
- However, we cannot guarantee the security of data transmitted over the  
Internet and we recommend that you be careful when transmitting confidential  
information.
-------------------------------------------------------------------------------
__Thank you for accepting these terms and conditions and for your cooperation__ 
__to keep us all safe.__
-------------------------------------------------------------------------------

EOF

## __Activación de servicio__
# echo -e "$cian Activando servicio $default"
# systemctl enable $UNIT

## __Reinicio de servicio__
# echo -e "$cian Reiniciando servicio $default"
# systemctl restart $UNIT

## __Verificación de servicio__
# echo -e "$cian Verificando servicio $default"
# systemctl status $UNIT

## __Verificacion de configuración__
# echo -e "$cian Verificando configuración $default"

