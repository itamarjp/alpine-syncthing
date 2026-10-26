# alpine-syncthing

Imagem [Syncthing](https://syncthing.net) baseada em `alpine:edge`, multi-arch
(amd64, arm64, armv7, **riscv64**), publicada em `ghcr.io/itamarjp/alpine-syncthing`.

## Uso

```sh
docker run -d --name syncthing \
  -e PUID=1000 -e PGID=1000 \
  -v /srv/syncthing:/var/syncthing \
  -p 8384:8384 -p 22000:22000/tcp -p 22000:22000/udp -p 21027:21027/udp \
  --restart unless-stopped \
  ghcr.io/itamarjp/alpine-syncthing:latest
```

GUI em `http://<host>:8384` — defina usuário/senha no primeiro acesso.

| Variável | Padrão | Descrição |
|---|---|---|
| `PUID` / `PGID` | `1000` | UID/GID que roda o syncthing |
| `STHOMEDIR` | `/var/syncthing/config` | Config e chaves |
| `STGUIADDRESS` | `0.0.0.0:8384` | Endereço da GUI |

Pastas sincronizadas: use `/var/syncthing/data` (ou monte volumes extras).
