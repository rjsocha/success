# syntax=docker/dockerfile:1.5
FROM alpine AS mold
ARG TARGETARCH
ARG TARGETVARIANT
RUN apk add gcc
ARG TARGET=${TARGETARCH}${TARGETVARIANT}
RUN mkdir -p /output
COPY src/${TARGET}.s .
RUN as -o ${TARGET}.o ${TARGET}.s
# Smaller size byt Mac OS X (M1) dump assertion (on linux/amd64 binary):
# assertion failed [segment_file_size >= size_of_elf_and_program_headers]: first load segment does not span the elf header size
#RUN ld -n -s -o /output/success ${TARGET}.o
RUN ld -s -o /output/success ${TARGET}.o
COPY src/ /output/.src/
COPY Dockerfile /output/.src/

FROM scratch
COPY --from=mold /output/ /
ENTRYPOINT [ "/success" ]
