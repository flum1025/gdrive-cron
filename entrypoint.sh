#! /bin/sh

if [ ! -z "$CRON" ]; then
  echo "$CRON /mounter.sh \"$COMMAND\"" > /var/spool/cron/crontabs/root
else
  echo "FATAL: \$CRON not found"
  exit 1
fi

cat /var/spool/cron/crontabs/root

crond -l 2 -f -L /dev/stdout
