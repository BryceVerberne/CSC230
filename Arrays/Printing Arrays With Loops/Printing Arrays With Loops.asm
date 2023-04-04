# Title:  Printing Arrays w/ Loops
# Desc:   This program demonstrates how to print the contents of an array with a while loop
# Author: Bryce Verberne
# Date:   04/04/2023



# Info:
#  - 

.data
  myArray: .space 12  # We want to store three integers, so we need 12 bytes. 

.text
  .globl main
main:
  # Load array values into $s# registers
  addi $s0, $zero, 4
  addi $s1, $zero, 10
  addi $s2, $zero, 12

  # Index (offset)
  add $t0, $zero, $zero  # Clear $t0
  
  # Store values in array
  sw $s0, myArray($t0    # Store $s0, which holds 4
  addi $t0, $t0, 4        
                          
  sw $s1, myArray($t0)   # Store $s1, which holds 10
  addi $t0, $t0, 4
  
  sw $s2, myArray($t0)   # Store $s2, which holds 12
  
  
  # Terminating Program
  li $v0, 10
  syscall