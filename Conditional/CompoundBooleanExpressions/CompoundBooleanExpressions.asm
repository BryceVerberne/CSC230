# Title:  Compound Boolean Expressions
# Desc:   We are writing compound boolean expressions
# Author: Bryce Verberne
# Data:   02/21/2023



# printf("Enter a number between 0 and 10");
# scanf("%d", &x);
# if (x > 0 && x < 10)
#    printf("Good Panda);
# else
#    printf("Hung over much???");
# endif

.include "MyMacros.asm"   # Use the preprocessor directive to include that file into this code
   
.data
   prompt: .asciiz "Enter a number between 0 and 10\n"
   gp:     .asciiz "\nGood Panda"
   bp:     .asciiz "\nBad Panda"
   
.text 
  .globl main
main:
   printString prompt     # Use the printString macro to print prompt
   readInt $t0            # Use the readInt macro to read an int and store it in $t0
   printInt $t0
   
   # if (x > 0 && x < 10)
   sgt $t1, $t0, $zero    # Set $t1 if x > 0 (Remember x is in $t0)
   slti $t2, $t0, 10       # Set $t2 if x < 10
   and $t1, $t1, $t2      # AND to determine whether $t1 and $t2 have equal values
                          # AND is a bitwise comparison, so if both bits are 1, then the resulting bit is 1.
   beq $t1, $zero, else
     printString gp       # Print "Good Panda"
     b endIf
   #    printf("Good Panda");
   # else
   else:
     printString bp       # Print "Bad Panda"
   # endIf
   endIf:
   
   
   # Terminating program
   done
