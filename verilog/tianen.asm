 lbi r5, 10
 nop
 nop
 nop
 j .return_from_prime
 
 .return_from_prime:
 beqz r5 .try_next_number
 addi r5 r6 0	// when halts, should have next prime number value 12373 0x3055
 halt
 
 .try_next_number:
 addi r0 r6 2
 halt