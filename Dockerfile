# syntax=docker/dockerfile:1.6
FROM alpine:3 AS mold
ARG TARGETARCH
ARG TARGETVARIANT
ARG TARGET=${TARGETARCH}${TARGETVARIANT}
RUN apk add --no-cache gcc
WORKDIR /build
COPY src/${TARGET}.s .
RUN as -o ${TARGET}.o ${TARGET}.s
# Smaller size byt Mac OS X (M1) dump assertion (on linux/amd64 binary):
# assertion failed [segment_file_size >= size_of_elf_and_program_headers]: first load segment does not span the elf header size
#RUN ld -n -s -o /output/success ${TARGET}.o
RUN ld -s -o success ${TARGET}.o
WORKDIR /mold/.entrypoint
WORKDIR /mold/.wyga
COPY src src/
WORKDIR /mold
COPY Dockerfile .wyga/
RUN cp /build/success .entrypoint/success

FROM scratch
COPY --from=mold /mold /
ENTRYPOINT [ "/.entrypoint/success" ]
