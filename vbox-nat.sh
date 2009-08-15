#!/bin/bash
#commandes à taper pour rediriger le port physique 2222 vers le port virtuel 22 de la machine virtuelle UbuntuRails
if [[ $# -lt 3 ]] ;then
	echo usage: $0 VM GuestPort HostPort
	echo WARNING: destination path must be relative to src
	exit -1
fi
vboxmanage setextradata "UbuntuRails" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/Protocol" TCP
vboxmanage setextradata "UbuntuRails" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/GuestPort" $1
vboxmanage setextradata "UbuntuRails" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/HostPort" $2
exit 0
