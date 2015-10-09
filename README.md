# cosmac-hacks
Various programs for the Membership Card / RCA 1802

Due to my interests in both embedded / low-level programming and 
retro electronics, I started hacking with a modern version of the
70's COSMAC ELF.

## Hardware
Currently, I'm running these programs on the Membership Card (Rev. G) 
by Lee Hart et al.
http://www.retrotechnology.com/memship/memship.html

## Programming tips
In lack of better code format, I'm following the conventions at
http://www.ittybittycomputers.com/IttyBitty/ShortCor.htm

So, each of the machine instructions take one row with the following fields:
- *address* in hex
- *binary code* in hex
- *label:* (optional)
- *mnemonic*
- *operand* (when applicable, sometimes represented by the next byte)
- *.. comment* (the two dots are the comment separator)

Example:
```
0003 E7 LOOP:   SEX 7  .. register address of a memory address
```

## TODO: more programs...
At least the following are planned:
- memtest: The amount of RAM can be doubled by installing another 32k RAM
  chip and using the 16th address bit (and its inverse) for the chip output 
  enable pins. However, the bit-inverting FET in Rev. G might not work 
  reliably with all RAM chips, so there is a need for a test program.
- bytebeat: This would require an 8-bit 8kHz "sound card" =)


-Janne, OH2GXN
