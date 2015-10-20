.. This program is an extension of the ETOPS program from Popular Electronics.
.. This version allows for full 16-bit addresses.
..  00 - Run program. The program will execute with R0
..  01 - Examine Memory. This function allows you to examine memory, while
..       the IN button is pressed, the data displays will show the next low
..       address to be displayed. When the IN button is released, the data
..       byte will be displayed.
..  02 - Modify Memory. This function allows you to enter bytes into memory.	
..       Like the 01 function, while the IN button is pressed, the low address
..       of the next address to be written will be displayed, when IN is
..       released the toggles will be read and the value stored into
..       memory. In this mode the Q led will be lit to remind you that you
..       are in modify mode.
.. Source: http://www.elf-emulation.com/software/rctops.html
    1 0000:                        org     0
    2 0000: 90                     ghi     r0                  ; setup stack
    3 0001: b2                     phi     r2
    4 0002: f8 3b                  ldi     low scratch
    5 0004: a2                     plo     r2
    6 0005: e2                     sex     r2
    7 0006: 90                     ghi     r0
    8 0007: b3                     phi     r3
    9 0008: f8 0c                  ldi     low start
   10 000a: a3                     plo     r3
   11 000b: d3                     sep     r3
   12 000c: 6c          start:     inp     4                   ; get command code
   13 000d: 64                     out     4                   ; write to data displays
   14 000e: 22                     dec     r2                  ; keep pointing to scratch
   15 000f: a1                     plo     r1                  ; save command code
   16 0010: 3f 10                  bn4     $                   ; wait for in to be pressed
   17 0012: 37 12                  b4      $                   ; wait for release
   18 0014: 6c                     inp     4                   ; get high address
   19 0015: 64                     out     4                   ; display it
   20 0016: 22                     dec     r2
   21 0017: b0                     phi     r0                  ; put into address register
   22 0018: 3f 18                  bn4     $                   ; wait for in to be pressed
   23 001a: 37 1a                  b4      $                   ; wait for release
   24 001c: 6c                     inp     4                   ; get high address
   25 001d: 64                     out     4                   ; display it
   26 001e: 22                     dec     r2
   27 001f: a0                     plo     r0                  ; put into address register
   28 0020: 81                     glo     r1                  ; get command code
   29 0021: 3a 24                  bnz     notrun              ; jump if not run
   30 0023: d0                     sep     r0                  ; transfer control
   31 0024: ff 01       notrun:    smi     1                   ; check for view
   32 0026: 32 29                  bz      mnloop              ; go to main loop
   33 0028: 7b                     seq                         ; enable write mode
   34 0029: 3f 29       mnloop:    bn4     $                   ; wait for IN to be pressed
   35 002b: 80                     glo     r0
   36 002c: 52                     str     r2
   37 002d: 64                     out     4
   38 002e: 22                     dec     r2
   39 002f: 37 2f                  b4      $                   ; and released
   40 0031: 39 35                  bnq    noload               ; jump if not in load mode
   41 0033: 6c                     inp     4                   ; read switches
   42 0034: 50                     str     r0                  ; store into memory
   43 0035: 40          noload:    lda     r0                  ; get byte from memory
   44 0036: 52                     str     r2                  ; ready for out
   45 0037: 64                     out     4                   ; write to displays
   46 0038: 22                     dec     r2
   47 0039: 30 29                  br      mnloop              ; loop back
   48 003b: 00          scratch:   db      0
