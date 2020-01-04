FROM alpine as build

RUN apk add --no-cache opam make build-base gcc abuild binutils ocaml-compiler-libs ocaml-ocamldoc m4 && \
  OPAMYES=true opam init --disable-sandboxing && \
  OPAMYES=true opam install ocamlfind && \
  OPAMYES=true opam depext google-drive-ocamlfuse && \
	OPAMYES=true opam install google-drive-ocamlfuse

FROM alpine

COPY --from=build /root/.opam/default/bin/google-drive-ocamlfuse /bin/google-drive-ocamlfuse

RUN apk add --no-cache sqlite-libs fuse libcurl libgmpxx bash tzdata tar pigz jq curl postgresql && \
  mkdir -p /mnt/src && \
  echo -e "#! /bin/sh\necho \$* > /dev/stderr" >> /bin/firefox && \
  chmod +x /bin/firefox && \
  echo "* * * * * echo 'sample cron'" > /var/spool/cron/crontabs/root

ENV TZ Asia/Tokyo

COPY ./mounter.sh /mounter.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
