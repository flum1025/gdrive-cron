#! /bin/sh

set -eu

echo "INFO: start"

echo "INFO: google-drive-ocamlfuse mount"

google-drive-ocamlfuse /mnt/src

echo "INFO: call callback"

eval $1

echo "INFO: end callback"

echo "INFO: umount"

umount /mnt/src

echo "INFO: end"
