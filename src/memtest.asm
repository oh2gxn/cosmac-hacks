.. Tests each byte of RAM by writing and reading the given pattern.
.. Starts from the first free byte and counts to the last byte available.
.. Turns Q on in case of failure.
.. Author: Janne Toivola
0000 7A INIT:   REQ    .. Turn Q off to be sure
0001 90         GHI 0  .. D = R0.hi == 0
0002 B1         PHI 1  .. R1.hi = D == 0
0003 B2         PHI 2  .. R2.hi = D == 0
0004 F8         LDI    .. D = 
0005 xx                ..   0x10, FIXME: END+1
0006 A1         PLO 1  .. R1.lo = D, R1 = END+1
0007 A2         PLO 2  .. R2.lo = D, R2 = END+1 (but incremented soon)
0008 E2         SEX 2  .. prepare to OUTput R2.hi (the loop has this too)
0009 12 LOOP:   INC 2  .. R2++ to test the next byte of RAM
000A 92         GHI 2  .. D = R2.hi (value to be displayed)
000B 52         STR 2  .. *R2 = D   (since OUT uses only stuff in RAM)
000C 64         OUT 4  .. leds = *R2 (== R2.hi, or gibberish, if RAM fails)
000D E1         SEX 1  .. X = 1, use R1 as the address register for input
000E 6C         INP 4  .. *R1 = D = input switches
000F E2         SEX 2  .. X = 2, use R2 as the address register for testing	
0010 52         STR 2  .. *R2 = D
0011 F3         XOR    .. D = xor(D,*R2), which is 0x00, if RAM works!
0012 3A         BNZ    .. Branch if not 0x00
0013 xx                ..   to FAIL
0014 82         GLO 2  .. D = R2.lo
0015 FB         XRI    .. D = xor(D,
0016 FF                ..   0xFF) to test if R2.lo != 0xFF
0017 3A         BNZ    .. Branch if not 0x00 (at least few bytes left)
0018 xx                ..   to LOOP
0019 92         GHI 2  .. D = R2.hi
001A FB         XRI    .. D = xor(D,
001B 7F                ..   0x7F) to test if R2.hi != 0x7F (32k limit!)
001C CE         LSZ    .. Skip BR if R2 == 0x7FFF (PASS)
001D 30         BR     .. Goto
001E 09                ..   LOOP	
001F 38 PASS:   SKP    .. skip error indication
0020 7B FAIL:   SEQ    .. turn Q on (TODO: blink R2.lo / R2.hi alternately)
0021 00 END:    IDL    .. stop here
