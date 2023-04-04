.arch   armv8-a
.align  2
.global _start
.text
_start:
  mov w8, 93
  mov x0, 0
  svc #0
