srli r0, r7, 1 // This test will test the corner case where the immediate may be mistaken for a register and accidentally forward.
j 0 
lbi r3, 0 
lbi r0, 0
halt