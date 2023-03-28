# Title:  Branching
# Desc:   This program demonstrates a basic branching instruction. 
# Author: Bryce Verberne
# Date:   03/28/2023



.include "MyMacros.asm"

.text
  .globl main
main:

  li $t0, 3
  li $t1, 4
  
  branch1:
    readInt $t2              # Read an integer into $t2
    seq $t3, $t2, 3          # Set $t2 if $t0 is 3
    beq $t3, $zero, branch2
    add $t0, $t0, $t1
    b branch1
  branch2: 
    # Terminate Program
    done