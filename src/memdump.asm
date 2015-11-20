.. Dumps each byte of RAM to output (TODO: control the address and loop over?)
.. Author: Janne Toivola
0000 90 INIT:   GHI 0  .. D = R0.hi == 0 (since PC is reset to INIT)
0001 B3         PHI 3  .. R3.hi = D == 0
0002 F8         LDI    .. D = 
0003 19                ..   DATA
0004 A3         PLO 3  .. R3.lo = D, R3 == DATA (skip this program)
0005 E3         SEX 3  .. to use *R3 in OUT
0006 64 LOOP:   OUT 4  .. leds = *(R3++)
0007 90         GHI 0  .. D = R0.hi == 0
0008 C4 DELAY:  NOP    .. do nothing for a while (adjusts the delay time)
0009 FC         ADI    .. D += 
000A 01                ..   1   (speed of doing nothing for a while)
000B 3B         BNF    .. Branch if DF==0 (D < 256)
000C 06                ..   to DELAY
000D 83         GLO 3  .. D = R3.lo
000E FB         XRI    .. D = xor(D,
000F FF                ..   0xFF) to test if R3.lo != 0xFF
0010 3A         BNZ    .. Branch
0011 04                ..   to LOOP (at least few bytes left)
0012 93         GHI 3  .. D = R3.hi (R3.lo == 0xFF at this point)
0013 FB         XRI    .. D = xor(D,
0014 FF                ..   0xFF) to test R3.hi (Use 7F for 32k RAM!)
0015 3A         BNZ    .. Branch
0016 04                ..   to LOOP (at least 256 bytes left)
0017 7B         SEQ    .. turn Q on
0018 00 STOP:   IDL    .. stop, leaving Q on
0019 00 DATA:          .. (this area of the memory was to be explored)
