#! /bin/sh

set -eu

echo "INFO: start"

if [ -n "$CHECK_URL" ]; then
  curl -fsS --retry 3 $CHECK_URL/start

  trap "curl -fsS --retry 3 $CHECK_URL/fail" ERR
fi

echo "INFO: google-drive-ocamlfuse mount"

google-drive-ocamlfuse /mnt/src

echo "INFO: call callback"

eval $1

echo "INFO: end callback"

echo "INFO: umount"

umount /mnt/src

if [ -n "$CHECK_URL" ]; then
  curl -fsS --retry 3 $CHECK_URL
fi

echo "INFO: end"
