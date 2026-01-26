mov $65532 %r21 ;out string
mov $48 %r23; second unit counter
mov $48 %r24; second tens counter
mov $48 %r25; minute unit counter
mov $48 %r26; minute tens counter

beginning_program:
store %r21 %r26
store %r21 %r25
store %r21 $58
store %r21 %r24
store %r21 %r23
store %r21 $10
add $1 %r23 %r23
cmp $58 %r23 ;if 10 seconds has passed
jlt beginning_program
mov $48 %r23
add $1 %r24 %r24
cmp $54 %r24 ;if 1 minute has passed
jlt beginning_program
mov $48 %r24
add $1 %r25 %r25
cmp $58 %r25 ;if 10 minutes have passed
jlt beginning_program
mov $48 %r25
add $1 %r26 %r26
jmp beginning_program
