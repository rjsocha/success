.machine    power8
.abiversion 2
.section    .text
.align      2
.global     _start
_start:
  li  0, 1
  li  3, 0
  sc
