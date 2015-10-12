.. Tests each byte of RAM by writing and reading the given pattern.
.. Starts from the first free byte and counts to the last byte available.
.. Turns Q on in case of inconsistency and halts at the address.
.. Author: Janne Toivola
0000 90 INIT:   GHI 0  .. D = R0.hi == 0 (since PC is reset)
0001 B1         PHI 1  .. R1.hi = D == 0
0002 B2         PHI 2  .. R2.hi = D == 0
0003 F8         LDI    .. D = 
0004 20                ..   0x20 == END+1
0005 A1         PLO 1  .. R1.lo = D, R1 == END+1
0006 A2         PLO 2  .. R2.lo = D, R2 == END+1 (but incremented soon)
0007 7A         REQ    .. Turn Q off to be sure
0008 E2         SEX 2  .. prepare to OUTput R2.hi (the loop has this too)
0009 92 LOOP:   GHI 2  .. D = R2.hi (value to be displayed)
000A 52         STR 2  .. *R2 = D   (since OUT uses only stuff in RAM)
000B 64         OUT 4  .. leds = *(R2++) (R2.hi, or gibberish, if RAM fails?)
000C E1         SEX 1  .. X = 1, use R1 as the address register for input
000D 6C         INP 4  .. *R1 = D = input switches
000E E2         SEX 2  .. X = 2, use R2 as the address register for testing	
000F 52         STR 2  .. *R2 = D
0010 F3         XOR    .. D = xor(D,*R2), which is 0x00, if RAM works!
0011 3A         BNZ    .. Branch if not 0x00
0012 20                ..   to FAIL
0013 82         GLO 2  .. D = R2.lo
0014 FB         XRI    .. D = xor(D,
0015 FF                ..   0xFF) to test if R2.lo != 0xFF
0016 3A         BNZ    .. Branch if not 0x00 (at least few bytes left)
0017 09                ..   to LOOP
0018 92         GHI 2  .. D = R2.hi (R2.lo == 0xFF below this point)
0019 FB         XRI    .. D = xor(D,
001A 7F                ..   0x7F) to test if R2.hi != 0x7F (32k limit!)
001B 3A         BNZ    .. Branch
001C 09                ..   to LOOP (more than 256 bytes left)
001D 00 PASS:   IDL    .. stop, leaving R2.hi visible, but Q off
001E 7B FAIL:   SEQ    .. turn Q on (TODO: blink R2.lo / R2.hi alternately)
001F 00         IDL    .. stop, leaving R2.hi and Q visible
0020 00                .. for storing the test pattern (*R1)
