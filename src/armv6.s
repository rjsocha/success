.arch   armv6zk
.align  2
.arm
.global _start
.text
_start:
  mov r7, #1
  mov r0, #0
  swi #0
