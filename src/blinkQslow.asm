.. Test program 2 from the 1802 Membership Card manual by Lee Hart
.. while (1){
..   for (R2 = 0x0800, 0 < R2&0xFF00, R2--);
..   if Q==0
..     Q=1;
..   else
..     Q=0;
.. }
0000 F8 START:  LDI    .. Load immediate value
0001 08                ..   8
0002 B2         PHI 2  .. Put it into HI half of R2
0003 22 LOOP:   DEC 2  .. Decrement R2 (16 bits)
0004 92         GHI 2  .. Get HI half of R2
0005 3A         BNZ    .. Branch if not zero
0006 03                ..   to LOOP
0007 CD         LSQ    .. Skip next 2 instructions, if Q=1
0008 7B ON:     SEQ    .. Set Q (on)
0009 38         SKP    .. Skip next instruction
000A 7A OFF:    REQ    .. Reset Q (off)
000B 30         BR     .. Branch
000C 00                ..   back to START
