# Title:  if...else
# Desc:   This program demonstrates how to write branching statements.
# Author: Bryce Verberne
# Data:   02/21/2023



.data
  prompt:   .asciiz "Enter a number.\n"
  negative: .asciiz "negative"
  positive: .asciiz "positive"
  zero:     .asciiz "zero"
   
.text
  .globl main
main:
   
  la $a0, prompt
  li $v0, 4
  syscall
   
  li $v0, 5
  syscall
   
  move $t0, $v0

  # if ($t1 < 0)
  slt $t1, $t0, $zero     # Sets $t1 to one if $t0 is < 0
  beq $t1, $zero, elseIf  # If $t1 is zero, then the condition is false, take the branch. 
    la $a0, negative
    li $v0, 4
    syscall
    b endIf
      
  elseIf:                 # else if ($t1 > 0)
    sgt $t1, $t0, $zero   
    beq $t1, $zero, else
      
    la $a0, positive
    li $v0, 4
    syscall
    b endIf
      
  else: 
    la $a0, zero
    li $v0, 4
    syscall
      
  endIf:


  # Terminating program
  li $v0, 10 
  syscall
