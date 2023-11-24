# wyga/success

Minimal/small NOP container (that's it - it's do noting and return 0 exit code).

## Why

I'm using this image as base for setting up owner/permisions for for volumes.

## Image

```
wyga/success:latest
```

# Project

  - [https://github.com/rjsocha/success](https://github.com/rjsocha/success)
  - [https://hub.docker.com/r/wyga/success](https://hub.docker.com/r/wyga/success)

## Platforms

  - linux/amd64
  - linux/386
  - linux/arm/v6
  - linux/arm/v7
  - linux/arm64/8
  - linux/ppc64le
  - linux/s390x

## Examples

### Setting sticky bit on volume (Dockerfile.sticky)

```
# syntax=docker/dockerfile:1.5
FROM alpine AS mold
RUN mkdir -p -m 1777 /web/depot
FROM wyga/success
COPY --from=mold /web/ /web
```

### Setting www-data:www-data on volume (Dockerfile.www-data)

```
# syntax=docker/dockerfile:1.5
FROM alpine AS mold
RUN mkdir -p -m 0755 /web/depot && chown 33:33 /web/media
FROM wyga/success
COPY --from=mold /web/ /web
```

### Build

```
REGISTRY=example.pl/storage-setup
PLATFORM="linux/amd64,linux/386,linux/arm64/v8,linux/arm/v6,linux/arm/v7,linux/s390x,linux/ppc64le"
OUTPUT="--output type=image,push=true,compression=gzip,compression-level=9,force-compression=true,oci-mediatypes=true"
docker buildx build --provenance false --platform ${PLATFORM} ${OUTPUT} --pull -f Dockerfile.sticky -t $(REGISTRY):sticky .
```

### Usage

For example via docker compose:

```
services:
  storage-setup:
    image: example.pl/storage-setup:sticky
    restart: no
    volumes:
      - depot:/web/depot
    profiles:
      - setup
```

Run it as:
```
  docker compose run --rm storage-setup
```

## Alternative NOP

```
  ...
  command: ["/sbin/docker-init", "--version"]
  init: true
```
