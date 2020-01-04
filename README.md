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
$ docker run --privileged -it --rm -v $(pwd)/config:/root/.gdfuse/default -v $(pwd)/cron.json:/cron.json flum1025/gdrive-cron
```

Configure
---

Prepare file `cron.json`

```json
[
  {
    "cron": "* * * * *",
    "command": "echo $(date '+%Y%m%d%H%M%S') >> /mnt/src/hoge"
  }
]
```
