.. Tests each byte of RAM by writing and reading the given pattern.
.. Starts from the first free byte and counts to the last byte available.
.. Turns Q on in case of failure.
.. Author: Janne Toivola
0000 7A INIT:   REQ    .. Turn Q off to be sure
0001 90         GHI 0  .. D = R0.hi (== 0)
0002 B1         PHI 1  .. R1.hi = D
0003 B2         PHI 2  .. R2.hi = D
0004 F8         LDI    .. D = 
0005 xx                ..   0x10, FIXME: END+1
0006 A1         PLO 1  .. R1.lo = D
0007 F8         LDI    .. D = 
0008 xx                ..   0x11, FIXME: END+2
0009 A2         PLO 2  .. R2.lo = D
000A E2         SEX 2  .. prepare to output R2.hi (the loop has this too)
000B 92 LOOP:   GHI 2  .. D = R2.hi
000C 52         STR 2  .. *R2 = D
000D 64         OUT 4  .. leds = *R2 (== R2.hi, or gibberish, if RAM fails)
000E E1         SEX 1  .. X = 1, use R1 as the address register for I/O
000F 6C         INP 4  .. *R1 = D = switches
0010 E2         SEX 2  .. X = 2, use R2 as the address register for RAM	
0011 52         STR 2  .. *R2 = D
0012 F3         XOR    .. D = xor(D,*R2), which is 0x00, if RAM works!
0013 3A         BNZ    .. Branch if not 0x00
0014 xx                ..   to FAIL

0000 82         GLO 2  .. D = R2.lo
0000 FB         XRI    .. D = xor(D,
0000 FF                ..   0xFF) to test if R2.lo != 0xFF
0013 3A         BNZ    .. Branch if not 0x00
0000 xx                ..   to NEXT

0000 92         GHI 2  .. D = R2.hi
0000 FB         XRI    .. D = xor(D,
0000 7F                ..   0x7F) to test if R2.hi != 0x7F (32k limit!)
0013 32         BZ    .. Branch if 0x00
0000 xx                ..   to PASS, TODO: or skip next two bytes!

0000 12 NEXT:   INC 2  .. Increment address R2, TODO: do this above
0000 30         BR     .. Goto
0000 0B                ..   LOOP	
0000 38 PASS:   SKP    .. skip error indication
0000 7B FAIL:   SEQ    .. turn Q on
0000 00 END:    IDL    .. stop here
