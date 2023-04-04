# Title:  Heap & Interrupts
# Desc:   This program demonstrates how to allocate & fill memory, plus use exceptions.
# Author: Bryce Verberne
# Date:   04/04/2023

.data

.text
  .globl main
main:
  
  
  # Terminating Program
  li $v0, 10
  syscall