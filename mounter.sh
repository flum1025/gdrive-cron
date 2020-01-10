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

SOURCE_DIR="/mnt/src"
DATE=$(date '+%Y%m%d%H%M%S')
SAVE_DIR_CURRENT="/tmp/$DATE"

mkdir $SAVE_DIR_CURRENT

echo "INFO: call callback"

for file in `\find $SOURCE_DIR -maxdepth 1 -type d ! -path $SOURCE_DIR`; do
  echo "INFO: backup $file"

  name=$(basename $file)
  dirname=$(dirname $file)
  target_filename=$SAVE_DIR_CURRENT/$name.tgz
  cloud_path=$TARGET_DIR/$DATE/$name.tgz

  echo "INFO: -----tar export-----"
  tar cf $target_filename --use-compress-prog=pigz -C $dirname $name && :
  code=$?
  echo "INFO: --------------------"

  if [ $code -ne 0 -a $code -ne 1 ]; then
    echo "FATAL: tar error"
    exit $code
  fi

  rclone copy $target_filename gdrive:$cloud_path

  echo "INFO: complete $file to $cloud_path"
done

echo "INFO: end callback"

if [ -n "$CHECK_URL" ]; then
  curl -fsS --retry 3 $CHECK_URL && echo
fi

echo "INFO: end"
