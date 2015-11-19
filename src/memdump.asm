.. Dumps each byte of RAM to output (TODO: control the address and loop over?)
.. Author: Janne Toivola
0000 90 INIT:   GHI 0  .. D = R0.hi == 0 (since PC is reset to INIT)
0001 B1         PHI 1  .. R1.hi = D == 0
0002 A1         PLO 1  .. R1.lo = D, R1 == 0
0003 E1         SEX 1  .. to use *R1 in OUT
0004 64 LOOP:   OUT 4  .. leds = *(R1++)
0005 90         GHI 0  .. D = R0.hi == 0
0006 FC DELAY:  ADI    .. D += 
0007 01                ..   1
0008 3B         BNF    .. Branch if DF==0 (D < 256)
0009 06                ..   to DELAY
000A 81         GLO 1  .. D = R1.lo
000B FB         XRI    .. D = xor(D,
000C FF                ..   0xFF) to test if R1.lo != 0xFF
000D 3A         BNZ    .. Branch
000E 04                ..   to LOOP (at least few bytes left)
000F 91         GHI 1  .. D = R1.hi (R1.lo == 0xFF at this point)
0010 FB         XRI    .. D = xor(D,
0011 FF                ..   0xFF) to test R1.hi (Use 7F for 32k RAM!)
0012 3A         BNZ    .. Branch
0013 04                ..   to LOOP (at least 256 bytes left)
0014 7B         SEQ    .. turn Q on
0015 00 STOP:   IDL    .. stop, leaving Q on
0016 00 DATA:          .. (this area of the memory was to be explored)
