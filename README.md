docker google-drive-ocamlfuse
===

Authorization
---

```bash
$ docker run -it --rm -v $(pwd)/config:/root/.gdfuse/default flum1025/gdrive-cron google-drive-ocamlfuse
```

Usage
---

```bash
$ docker run \
  --privileged \
  -v $(pwd)/config:/root/.gdfuse/default \
  -e "CRON=* * * * *" \
  -e "CHECK_URL=hoge" \
  -e "COMMAND=echo $(date '+%Y%m%d%H%M%S') >> /mnt/src/hoge" \
  flum1025/gdrive-cron
```
