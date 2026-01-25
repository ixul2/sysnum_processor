mov $0 %r4
store %r4 $0
add $1 %r4 %r4
store %r4 $1
mov $0 %r4
loop:
mov %r4 %r5
load %r5 %r6
add $1 %r5 %r5
load %r5 %r7
add %r6 %r7 %r7
add $1 %r5 %r5
store %r5 %r7
add $r4 $1 $r4
jmp loop
