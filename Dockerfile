FROM alpine

RUN apk add --no-cache bash tzdata tar pigz jq curl postgresql tar pigz && \
  curl -o rclone-current-linux-amd64.zip https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
  unzip rclone-current-linux-amd64.zip && \
  mv rclone-*/rclone /usr/bin && \
  rm rclone-current-linux-amd64.zip

ENV TZ Asia/Tokyo

COPY ./mounter.sh /mounter.sh
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
