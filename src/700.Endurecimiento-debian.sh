#!/usr/bin/env bash

# Endurecimiento de Debian 12

## __Autoría y licencia__
###### Endurecimiento de Debian 12 © 2024 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [fuente]:(enlace)

## __Modificación de configuración__

###### Instalación de paquetes.
apt install -y screen mc btop htop iotop ncdu git man bind9-dnsutils lynis

###### Activación de registro remoto.
source "${0%/*}"/endurecimiento/LOGG-2154.sh
source "${0%/*}"/endurecimiento/BOOT-5264_rsyslog.sh

###### Instalación de paquetes nuevos.
source "${0%/*}"/endurecimiento/PKGS-7388.sh
source "${0%/*}"/endurecimiento/DEB-0280.sh
source "${0%/*}"/endurecimiento/DEB-0810.sh
source "${0%/*}"/endurecimiento/DEB-0811.sh
source "${0%/*}"/endurecimiento/DEB-0831.sh
source "${0%/*}"/endurecimiento/DEB-0880.sh
source "${0%/*}"/endurecimiento/USB-3000.sh
source "${0%/*}"/endurecimiento/AUTH-9250.sh
source "${0%/*}"/endurecimiento/AUTH-9252.sh
source "${0%/*}"/endurecimiento/AUTH-9262.sh
source "${0%/*}"/endurecimiento/CRYP-8005.sh
source "${0%/*}"/endurecimiento/HRDN-7230.sh
source "${0%/*}"/endurecimiento/LYNIS.sh
source "${0%/*}"/endurecimiento/NETW-3032.sh
source "${0%/*}"/endurecimiento/PKGS-7392.sh
source "${0%/*}"/endurecimiento/PKGS-7370.sh
source "${0%/*}"/endurecimiento/PKGS-7394.sh
source "${0%/*}"/endurecimiento/TOOL-5002.sh
source "${0%/*}"/endurecimiento/TOOL-5120.sh
source "${0%/*}"/endurecimiento/TOOL-5130.sh
source "${0%/*}"/endurecimiento/KRNL-5820.sh
source "${0%/*}"/endurecimiento/SHLL-6220.sh

###### Configuración de unattended-upgrades.
source "${0%/*}"/endurecimiento/PKGS-7420.sh
source "${0%/*}"/endurecimiento/BOOT-5264_unattended-upgrades.sh

###### Configuracion de ssh.
source "${0%/*}"/endurecimiento/SSH-7408.sh
# source "${0%/*}"/endurecimiento/BOOT-5264_sshd.sh

###### Bloqueo de módulos de kernel.
source "${0%/*}"/endurecimiento/NETW-3200.sh
source "${0%/*}"/endurecimiento/STRG-1846.sh
source "${0%/*}"/endurecimiento/USB-1000.sh

# source "${0%/*}"/endurecimiento/BOOT-5264_apache2.sh
# source "${0%/*}"/endurecimiento/BOOT-5264_CAP_test.sh
# source "${0%/*}"/endurecimiento/BOOT-5264_exim4.sh
# source "${0%/*}"/endurecimiento/BOOT-5264_gophernicus.sh
# source "${0%/*}"/endurecimiento/BOOT-5264_inetutils-inetd.sh
# source "${0%/*}"/endurecimiento/BOOT-5264_molly-brown.sh
# source "${0%/*}"/endurecimiento/BOOT-5264_tor.sh

###### Purga de paquetes.
source "${0%/*}"/endurecimiento/PKGS-7346.sh

###### Cambio de permiso de compiladores.
source "${0%/*}"/endurecimiento/HRDN-7222.sh

###### Configuracion de sysctl.
source "${0%/*}"/endurecimiento/KRNL-6000.sh

###### Configuración de auditd.
source "${0%/*}"/endurecimiento/ACCT-9622.sh
source "${0%/*}"/endurecimiento/ACCT-9626.sh
source "${0%/*}"/endurecimiento/ACCT-9628.sh
source "${0%/*}"/endurecimiento/ACCT-9630.sh
source "${0%/*}"/endurecimiento/BOOT-5264_auditd.sh

###### Configuración de AIDE.
source "${0%/*}"/endurecimiento/FINT-4350.sh
source "${0%/*}"/endurecimiento/FINT-4402.sh
source "${0%/*}"/endurecimiento/FINT-4316.sh

###### Endurecimiento de servicios.
source "${0%/*}"/endurecimiento/BOOT-5264_cron.sh
source "${0%/*}"/endurecimiento/BOOT-5264_dbus.sh
source "${0%/*}"/endurecimiento/BOOT-5264_dm-event.sh
source "${0%/*}"/endurecimiento/BOOT-5264_ifup.sh
source "${0%/*}"/endurecimiento/BOOT-5264_lvm2-lvmpolld.sh
source "${0%/*}"/endurecimiento/BOOT-5264_rc-local.sh
source "${0%/*}"/endurecimiento/BOOT-5264_systemd-ask-password-console.sh
source "${0%/*}"/endurecimiento/BOOT-5264_systemd-ask-password-wall.sh
source "${0%/*}"/endurecimiento/BOOT-5264_systemd-fsckd.sh
source "${0%/*}"/endurecimiento/BOOT-5264_systemd-initctl.sh
source "${0%/*}"/endurecimiento/BOOT-5264_systemd-udevd.sh

###### Configuración de contraseña de grub2.
source "${0%/*}"/endurecimiento/BOOT-5122.sh

###### Modificación de configuraciones.
source "${0%/*}"/endurecimiento/BANN-7126.sh
source "${0%/*}"/endurecimiento/BANN-7130.sh
source "${0%/*}"/endurecimiento/SHLL-6230.sh
source "${0%/*}"/endurecimiento/FILE-6344.sh
source "${0%/*}"/endurecimiento/FILE-6374.sh
source "${0%/*}"/endurecimiento/FILE-6430.sh
source "${0%/*}"/endurecimiento/FILE-7524.sh
source "${0%/*}"/endurecimiento/AUTH-9230.sh
source "${0%/*}"/endurecimiento/AUTH-9286.sh
source "${0%/*}"/endurecimiento/AUTH-9328.sh
source "${0%/*}"/endurecimiento/AUTH-9408.sh
source "${0%/*}"/endurecimiento/AUTH-9282.sh
source "${0%/*}"/endurecimiento/LOGG-2190.sh

###### Reboot
source "${0%/*}"/endurecimiento/KRNL-5830.sh
