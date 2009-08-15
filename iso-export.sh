#!/bin/bash
if [[ $# -lt 2 ]] ;then
	echo usage: $0 src destination
	echo WARNING: destination path must be relative to src
	exit -1
fi
cd $1
mkisofs -R -o $2 -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
exit 0
