gdrive-cron
===

Authorization
---

```bash
$ docker run -it --rm -v $(pwd)/config:/root/.config/rclone flum1025/gdrive-cron:20200110223857 rclone config
```

Usage
---

```bash
$ docker run \
  --privileged \
  -v $(pwd)/config:/root/.config/rclone \
  -e "CRON=* * * * *" \
  -e "CHECK_URL=healthchecks.io url" \
  -e "TARGET_DIR=path/to/backup/dir/in/google/drive"
  flum1025/gdrive-cron
```
