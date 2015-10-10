.. Test program 3 from the 1802 Membership Card manual by Lee Hart:
.. turns on the 8 output leds based on the 8 input switches.
.. The gadget was renamed as "Valotin" / "Lightifier" by Eino (4 yrs).
0000 E1 START:  SEX 1  .. X = 1, use R1 as the address register
0001 90         GHI 0  .. D = R0.hi (== 0)
0002 B1         PHI 1  .. R1.hi = D
0003 F8         LDI    .. D = 
0004 10                ..   0x10 (after the end of this program)
0005 A1         PLO 1  .. R1.lo = D, (R1 == 0x0010 now)
0006 6C IN:     INP 4  .. *R1 = port4.in
0007 64 OUT:    OUT 4  .. port4.out = *R1
0008 30         BR     .. goto
0009 00                ..   START
