# cosmac-hacks
Various programs for the 1802 Membership Card

Due to my interests in both embedded / low-level programming and 
retro electronics, I started hacking with a modern version of the
70's COSMAC ELF.


## Hardware
Currently, I'm running these programs on the 1802 Membership Card (Rev. G) 
by Lee Hart et al.
http://www.retrotechnology.com/memship/memship.html


## Programming tips
In lack of better code format, I'm following the conventions at
http://www.ittybittycomputers.com/IttyBitty/ShortCor.htm

So, each of the bytes in the object code is represented by one row with the 
following fields:
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


## List of current programs
The test programs from the 1802 Membership Card manual:
- `blinkQfast`: a test program flipping Q on/off as fast as possible
- `blinkQslow`: a similar test with a delay loop
- `valotin`: test for reading input switches and controlling output LEDs

There was no mention about a software licence, but I suppose sharing these simple examples falls into the category of "fair use". Besides, the comments and potential bugs are mine :)


## TODO: more programs...
At least the following are planned:
- `memtest`: The amount of RAM can be doubled by installing another 32k RAM
  chip and using the 16th address bit (and its inverse) for the chip output 
  enable pins. However, the bit-inverting FET in Rev. G might not work 
  reliably with all RAM chips, so there is a need for a test program.
- `bytebeat`: This would require an 8-bit 8kHz "sound card" =)


-Janne, OH2GXN
