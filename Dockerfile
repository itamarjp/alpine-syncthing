FROM alpine:edge

ARG PUID=1000
ARG PGID=1000

RUN apk add --no-cache syncthing ca-certificates tzdata su-exec \
 && mkdir -p /var/syncthing/config /var/syncthing/data

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PUID=${PUID} \
    HOME=/var/syncthing \
    PGID=${PGID} \
    STHOMEDIR=/var/syncthing/config \
    STGUIADDRESS=0.0.0.0:8384 \
    STNOUPGRADE=1

VOLUME ["/var/syncthing"]

# 8384 GUI, 22000 sync (TCP/QUIC), 21027 discovery local
EXPOSE 8384 22000/tcp 22000/udp 21027/udp

HEALTHCHECK --interval=1m --timeout=10s \
  CMD wget -qO- http://127.0.0.1:8384/rest/noauth/health | grep -q OK || exit 1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["syncthing", "serve", "--no-browser"]
