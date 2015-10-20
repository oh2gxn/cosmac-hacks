.. Elf Toggle OPerating System for 256-byte memory
.. Popular Electronics, March 1977
.. http://incolor.inebraska.com/bill_r/elf/html/elf-3-64.htm
0000   F8  20  A1   .. R1.0 = work
0003   E1           .. X=1
0004   6C  64  21   .. D = toggles
0007   3F  07       .. Wait for IN on
0009   37  09       .. Wait for IN off
000B   32  1D       .. M(1D) if D=00
000D   F6  33  11   .. M(11) if D=01
0010   7B           .. Q=1
0011   6C  A1       .. R1.0 = toggles
0013   3F  13       .. Wait for IN on
0015   37  15       .. Wait for IN off
0017   39  1A       .. M(1A) if Q=0
0019   6C           .. M1 = toggles
001A   64           .. Show M1, R1 + 1
001B   30  13       .. Repeat M(13)
001D   6C  A3       .. R3.0 = toggles
001F   D3           .. P=3
0020   00           .. Work area
0021   User programs from M(21) to M(FF)
