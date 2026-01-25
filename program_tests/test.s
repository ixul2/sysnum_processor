mov $65532 %r21 ;out string
beg:
cmp $60 %r0
jd print
jmp fin
print:
store %r21 $65
fin:
