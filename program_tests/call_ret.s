mov $65450 %r1
mov $5 %r4
call oui
add %r0 %r0 %r0
add $1 %r0 %r0
add %r0 %r0 %r0
add %r0 %r0 %r0
add %r0 %r0 %r0
add %r0 %r0 %r0
add %r0 %r0 %r0
add %r0 %r0 %r0
add %r0 %r0 %r0
oui:
add $1 %r4 %r4
ret
