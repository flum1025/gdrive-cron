#! /bin/sh

if [[ -f /cron.json ]]; then
  echo "INFO: found /cron.json"
  cat /cron.json
  cat /cron.json | jq -r '.[] | .cron + " /mounter.sh \"" + .command + "\""' > /var/spool/cron/crontabs/root
else
  echo "WARN: /cron.json is not found."
fi

cat /var/spool/cron/crontabs/root

crond -l 2 -f
