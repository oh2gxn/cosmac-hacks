.. Tests each byte of RAM by writing and reading the given (switched) pattern N.
.. Starts from the first free byte and counts to the last byte available,
.. displaying the high byte of the address on LEDs (nice binary counter, eh).
.. In case of failure, turns Q on and halts at the failing address.
.. After the execution, RAM should have DATA = {FF, n, n, n...}.
.. TODO: This does not test HW bugs in addressing (e.g. pin A8==1),
.. which would require writing "unique" (or non-aligned) data for each byte,
.. then reading and testing it didn't get "out of phase" at some boundary.
.. Author: Janne Toivola
0000 90 INIT:   GHI 0  .. D = R0.hi == 0 (since PC is reset to INIT)
0001 B3         PHI 3  .. R3.hi = D == 0
0002 B4         PHI 4  .. R4.hi = D == 0
0003 B5         PHI 5  .. R5.hi = D == 0
0004 F8         LDI    .. D = 
0005 26                ..   DATA address
0006 A3         PLO 3  .. R3.lo = D, R3 == DATA (almost fixed)
0007 A4         PLO 4  .. R4.lo = D, R4 == DATA (but incremented soon)
0008 A5         PLO 5  .. R5.lo = D, R5 == DATA (but incremented soon)
0009 14         INC 4  .. R4++, DATA+1 is the address for test pattern
000A E4         SEX 4  .. X=4, R4 is the address register for input
000B 6C         INP 4  .. *R4 = D = input switches
000C E5         SEX 5  .. X=5, R5 is the address register for testing
000D 60 LOOP:   IRX    .. R5++, next address to be tested (== R4 at first)
000E 95         GHI 5  .. D = R5.hi (value to be displayed)
000F 53         STR 3  .. *R3 = D   (since OUT uses only RAM, not registers)
0010 E3         SEX 3  .. to use *R3 in OUT
0011 64         OUT 4  .. leds = *(R3++) (high byte of the current address)
0012 23         DEC 3  .. R3--, to compensate the damn address increment
0015 E5         SEX 5  .. back to using R5 (in XOR and IRX)
0014 04         LDN 4  .. D = *R4
0015 55         STR 5  .. *R5 = D
0016 F3         XOR    .. D = xor(D,*R5), which is 0x00, if RAM works!
0017 3A         BNZ    .. Branch
0018 24                ..   to FAIL
0019 85         GLO 5  .. D = R5.lo
001A FB         XRI    .. D = xor(D,
001B FF                ..   0xFF) to test if R5.lo != 0xFF
001C 3A         BNZ    .. Branch
001D 0D                ..   to LOOP (at least few bytes left)
001E 95         GHI 5  .. D = R5.hi (R5.lo == 0xFF at this point)
001F FB         XRI    .. D = xor(D,
0020 FF                ..   0xFF) to test R5.hi (Use 7F for 32k RAM!)
0021 3A         BNZ    .. Branch
0022 0D                ..   to LOOP (at least 256 bytes left)
0023 00 PASS:   IDL    .. stop, leaving R5.hi visible, but Q off
0024 7B FAIL:   SEQ    .. turn Q on (TODO: blink R5.lo / R5.hi / *R5 ?)
0025 00         IDL    .. stop, leaving R5.hi visible and Q ON
0026 00 DATA:          .. for storing the displayed value *R3
0027 00                .. for storing the test pattern *R4
