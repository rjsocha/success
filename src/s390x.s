.machinemode  zarch
.machine      "z196"
.align        8
.global       _start
.text
_start:
  lghi    %r1,1
  lghi    %r2,0
  svc 0
