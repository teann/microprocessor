lbi r3, 5 //This test will test general forwarding cases
lbi r1, 10
lbi r2, 15
nop
nop
nop
nop
add r4, r1, r2
sub r1, r4, r2
subi r4, r4, 1
halt