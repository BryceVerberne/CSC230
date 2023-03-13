# Title:  for Loop
# Desc:   This program contains a basic for loop.
# Author: Bryce Verberne
# Data:   02/21/2023


# for (int i = 0; i < 10; i++) 
#    printf("%s %d\n", "Iteration", i);
#  
   
# Initialize
# i
# 10 because of (i < 10)

.include "MyMacros.asm"

.data
   iteration: .asciiz "Iteration "
   
.text
  .globl main
   main:

   li $t0, 0   # $t0 is our i variable
   li $t1, 10  # $t1 is our limit
   
   for:
      slt $t2, $t0, $t1   # Set $t2 if i < 10
      beq $t2, $zero, endFor

      printString iteration
      printInt $t0
      printNewLine

      addi $t0, $t0, 1   # i++
      b for
   
   endFor:


   # Terminating Program
   done
