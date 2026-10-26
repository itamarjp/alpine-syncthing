#!/bin/sh
set -e

PUID="${PUID:-1000}"
PGID="${PGID:-1000}"

if [ "$(id -u)" = "0" ]; then
  getent group syncthing >/dev/null 2>&1 || addgroup -g "$PGID" syncthing 2>/dev/null || true
  getent passwd syncthing >/dev/null 2>&1 || \
    adduser -D -H -h /var/syncthing -u "$PUID" -G syncthing syncthing 2>/dev/null || true
  mkdir -p "$STHOMEDIR"
  chown "$PUID:$PGID" /var/syncthing "$STHOMEDIR"
  exec su-exec "$PUID:$PGID" "$@"
fi

exec "$@"
