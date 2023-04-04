# Title:  Heap & Interrupts
# Desc:   This program demonstrates how to allocate & fill memory, plus use exceptions.
# Author: Bryce Verberne
# Date:   04/04/2023


# We want to ask the user how many random #'s they want, & then generate those random #'s in an array. 

.data

.text
  .globl main
main:
  
  
  
  # Terminating Program
  li $v0, 10
  syscall