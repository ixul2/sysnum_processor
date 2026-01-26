mov $65520 %r1 ;initialize the stack
mov $65532 %r21 ;out string

mov $0 %r4
store %r4 $0
add $4 %r4 %r4
store %r4 $1
mov $0 %r4
loop:
mov %r4 %r5
load %r5 %r6
add $4 %r5 %r5
load %r5 %r7
add %r6 %r7 %r7
add $4 %r5 %r5
store %r5 %r7
mov %r7 %r5
call print_int
add %r4 $4 %r4
jmp loop

print_int: ;works for numbers from 0 to 99
mov $48 %r6 ;units
mov $48 %r7 ;tens
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
store %r21 $10
ret
