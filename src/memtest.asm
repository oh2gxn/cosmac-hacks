.. Tests each byte of RAM by writing and reading the given pattern.
.. Starts from the last address and counts down to the last byte occupied
.. by this program.
.. Author: Janne Toivola
0000 E1 START:  SEX 1  .. X = 1, use R1 as the address register for I/O
0001 90         GHI 0  .. D = R0.hi (== 0)
0002 B1         PHI 1  .. R1.hi = D
0003 F8         LDI    .. D = 
0004 10                ..   0x10 FIXME: END+1
0005 A1         PLO 1  .. R1.lo = D
0006 6C INPUT:  INP 4  .. *R1 = switches
0007 E2 INIT:   SEX 2  .. X = 2, use R2 as the address register for RAM
0008 F8         LDI    .. D =
0009 7F                ..   0x7F Starts from 32k, use FF for 64k RAM
000A B1         PHI 1  .. R2.hi = D
000B F8         LDI    .. D = 
000C FF                ..   0xFF
000D A1         PLO 1  .. R2.lo = D, (R2 == 0x7FFF now) TODO: STR for OUT?
000E E2 LOOPHI: SEX 2  .. prepare to output R2.hi
000F 92         GHI 2  .. D = R2.hi
000F 64         OUT 4  .. leds = *R2, FIXME: R2
000F 00 END:    IDL    .. stop here
