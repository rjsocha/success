.arch   armv7-a
.align  1
.global _start
.text
_start:
  mov r7, #1
  mov r0, #0
  swi #0
