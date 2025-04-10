#!/bin/bash

# Endurecimiento KRNL-6000

## __Autoría y licencia__
###### Endurecimiento KRNL-6000 © 2025 por \~ferorge
###### [ferorge@texto-plano.xyz](mailto:ferorge@texto-plano.xyz).
###### Licenciado bajo GNU Public License version 3.
###### Para ver una copia de esta licencia, visite:
###### [GPLv3]:(https://www.gnu.org/licenses/gpl.txt)

## __Fuente__
###### [KRNL-6000]:(https://linux-audit.com/linux-hardening-with-sysctl/)

## __Importación de colores__
source "${0%/*}"/../000.Colores.sh

## __Configuración de variables__
TEST='KRNL-6000'
UNIT=''
timestamp=$(date +%F_%H.%M.%S)

## __Instalación de paquetes__
# PKG=''
# apt install -y $PKG

## __Respaldo de configuración__
DIR='/usr/lib/sysctl.d/'
FILE='999-KRNL-6000.conf'
echo -e "$cian Respaldando $DIR$FILE $default"
cp $DIR$FILE /var/backups/$FILE.$timestamp

## __Modificación de configuración__
echo -e "$cian Modificando $DIR$FILE $default"
mkdir -p $DIR
echo "
########################
# Editado por ~ferorge #
########################
#
# $TEST
#
dev.tty.ldisc_autoload=0
fs.protected_fifos=2
fs.protected_hardlinks=1
fs.protected_regular=2
fs.protected_symlinks=1
fs.suid_dumpable=0
kernel.core_uses_pid=1
kernel.ctrl-alt-del=0
kernel.dmesg_restrict=1
kernel.kptr_restrict=2
kernel.modules_disabled=1
#kernel.perf_event_paranoid=2 3 4
kernel.randomize_va_space=2
kernel.sysrq=0
kernel.unprivileged_bpf_disabled=1
kernel.yama.ptrace_scope=1
net.core.bpf_jit_harden=2
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.all.bootp_relay=0
net.ipv4.conf.all.forwarding=0
net.ipv4.conf.all.log_martians=1
#net.ipv4.conf.all.mc_forwarding=0
net.ipv4.conf.all.proxy_arp=0
net.ipv4.conf.all.rp_filter=1 
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.default.accept_source_route=0 
net.ipv4.conf.default.log_martians=1
net.ipv4.icmp_echo_ignore_broadcasts=1 
net.ipv4.icmp_ignore_bogus_error_responses=1 
net.ipv4.tcp_syncookies=1
#net.ipv4.tcp_timestamps=0 1
net.ipv6.conf.all.accept_redirects=0
net.ipv6.conf.all.accept_source_route=0
net.ipv6.conf.default.accept_redirects=0
net.ipv6.conf.default.accept_source_route=0
########################
" >> $DIR$FILE

sysctl --system

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

