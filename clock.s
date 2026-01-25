mov $65520 %r1 ;initialize the stack
mov $65528 %r20 ;in time
mov $65532 %r21 ;out string
mov $0 %r23; second counter
mov $0 %r24; minute counter

beginning_program:
call print_time
load %r20 %r5
loop_check_time:
load %r20 %r6
cmp %r5 %r6
je loop_check_time
add $1 %r23 %r23
cmp $60 %r23 ;if one minute has passed
jd beginning_program
mov $0 %r23
add $1 %r24 %r24
jmp beginning_program

print_time:
push %r24
call print_int
store %r21 $58
push %r23
call print_int
store %r21 $10
ret

print_int: ;works for numbers from 0 to 99
pop %r5
mov $30 %r6 ;units
mov $30 %r7 ;tens
loop_print_int:
cmp %r5 $10
jlt add_unit
sub %r5 $10 %r5
add $1 %r7 %r7
jmp loop_print_int
add_unit:
add %r5 %r6 %r6
store %r21 %r7
store %r21 %r6
ret
