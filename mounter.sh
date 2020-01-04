#! /bin/bash

set -eu

echo "INFO: start"

if [ -n "$CHECK_URL" ]; then
  curl -fsS --retry 3 $CHECK_URL/start && echo

  function error_handler() {
    echo "ERROR" >&2
    curl -fsS --retry 3 $CHECK_URL/fail && echo
    exit 1
  }

  trap error_handler ERR
fi

echo "INFO: google-drive-ocamlfuse mount"

google-drive-ocamlfuse /mnt/src

echo "INFO: call callback"

eval $1

echo "INFO: end callback"

echo "INFO: umount"

umount /mnt/src

if [ -n "$CHECK_URL" ]; then
  curl -fsS --retry 3 $CHECK_URL && echo
fi

echo "INFO: end"
