.global _start
.text
_start:
  movl  $60, %eax
  xorl  %edi, %edi
  syscall
