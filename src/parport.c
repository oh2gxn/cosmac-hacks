#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <asm/io.h>

#define base 0x378   //LPT0

//to compile:  gcc -O parport.c -o parport
//after compiling, set suid:  chmod +s parport   then, copy to /usr/sbin/


int main(void) {
  if(ioperm(base,1,1))
    fprintf(stderr, "Couldn't open parallel port"), exit(1);

  outb(255,base);  //set all pins hi
  sleep(5);
  outb(0,base);    //set all pins lo

  return 0;
}
