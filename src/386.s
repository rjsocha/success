.global _start
.text
_start:
  xorl    %eax, %eax
  incl    %eax
  xorl    %ebx, %ebx
  int     $0x80
