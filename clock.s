mov $65520 %r1 ;initialize the stack
mov $65528 %r20 ;in time
mov $65532 %r21 ;out string

beginning_program:
load %r20 %r5
loop_check_time:
load %r20 %r6
cmp %r5 %r6
je loop_check_time
store %r21 $65
jmp beginning_program
