# Title:  Procedures in Loops
# Desc:   This program demonstrates how to call a procedure in a loop.
# Author: Bryce Verberne
# Date:   02/19/2023



.data
value: .asciiz "This is the current value of i: "

.text
  .globl main
main:

  # Create a loop that behaves the same as the following C program:
  # int i = 0
  # while (i < 10) {
  #    ++i;
  #    printf("This is the current value of i: %d", &i);
  # }
  addi $t0, $zero, 0   # Loading the value 0 in $t0 (i = 0)

  while: 
    bgt $t0, 10, exit # If $t0 < 10, then we exit the loop. bgt is a pseudo instruction
   
    jal printNumber   # This is how to call a function
   
    addi $t0, $t0, 1  # This is equivalent to saying ++i
   
    j while           # This is the jump instruction. Where do we want to jump? To the while variable, which will reevaluate $t0.
  exit: # You need two lables for assembly (while and exit).


  # Terminating program
  li $v0, 10
  syscall


printNumber: # This is a function
  la $a0, value
  li $v0, 4
  syscall
   
  move $a0, $t0
  li $v0, 1
  syscall
   
  li $a0, '\n'
  li $v0, 11
  syscall
      
  li $a0, '\n'
  li $v0, 11
  syscall
   
  jr $ra  # Return (jr stands for jump register)
