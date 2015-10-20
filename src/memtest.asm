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
0001 B1         PHI 1  .. R1.hi = D == 0
0002 B2         PHI 2  .. R2.hi = D == 0
0003 B3         PHI 3  .. R3.hi = D == 0
0004 F8         LDI    .. D = 
0005 26                ..   DATA address
0006 A1         PLO 1  .. R1.lo = D, R1 == DATA (almost fixed)
0007 A2         PLO 2  .. R2.lo = D, R2 == DATA (but incremented soon)
0008 A3         PLO 3  .. R2.lo = D, R3 == DATA (but incremented soon)
0009 12         INC 2  .. R2++, DATA+1 is the address for test pattern
000A E2         SEX 2  .. X=2, R2 is the address register for input
000B 6C         INP 4  .. *R2 = D = input switches
000C E3         SEX 3  .. X=3, R3 is the address register for testing
000D 60 LOOP:   IRX    .. R3++, next address to be tested (== R2 at first)
000E 93         GHI 3  .. D = R3.hi (value to be displayed)
000F 51         STR 1  .. *R1 = D   (since OUT uses only RAM, not registers)
0010 E1         SEX 1  .. to use *R1 in OUT
0011 64         OUT 4  .. leds = *(R1++) (high byte of the current address)
0012 21         DEC 1  .. R1--, to compensate the damn address increment
0013 E3         SEX 3  .. back to using R3 (in XOR and IRX)
0014 02         LDN 2  .. D = *R2
0015 53         STR 3  .. *R3 = D
0016 F3         XOR    .. D = xor(D,*R3), which is 0x00, if RAM works!
0017 3A         BNZ    .. Branch
0018 24                ..   to FAIL
0019 83         GLO 3  .. D = R3.lo
001A FB         XRI    .. D = xor(D,
001B FF                ..   0xFF) to test if R3.lo != 0xFF
001C 3A         BNZ    .. Branch
001D 0D                ..   to LOOP (at least few bytes left)
001E 93         GHI 3  .. D = R3.hi (R3.lo == 0xFF at this point)
001F FB         XRI    .. D = xor(D,
0020 FF                ..   0xFF) to test R3.hi (Use 7F for 32k RAM!)
0021 3A         BNZ    .. Branch
0022 0D                ..   to LOOP (at least 256 bytes left)
0023 00 PASS:   IDL    .. stop, leaving R3.hi visible, but Q off
0024 7B FAIL:   SEQ    .. turn Q on (TODO: blink R3.lo / R3.hi / *R3 ?)
0025 00         IDL    .. stop, leaving R3.hi visible and Q ON
0026 00 DATA:          .. for storing the displayed value *R1
0027 00                .. for storing the test pattern *R2
