# Title:  Array Basics
# Desc:   This program demonstrates how to make arrays
# Author: Bryce Verberne
# Date:   04/04/2023



# Info:
#  - An array is a collection of data. 
#  - An array is stored in RAM, where each one of its values are stored next to each other. 

.data
  # Arrays are created in the .data section & you must specify how much space your array takes up
  myArray: .space 12  # If we want to store 3 integers, we need 12 bytes since each integer takes up 4

.text
  .globl main
main:
  # These numbers are in our registers, but we want to store them in our array, which is in RAM
  addi $s0, $zero, 4
  addi $s1, $zero, 10
  addi $s2, $zero, 12

  # Index (offset)
  add $t0, $zero, $zero  # Clear $t0
  
  # Use sw to store words in 'myArray'
  # Start with $s0, which holds 4
  sw $s0, myArray($t0)    # Notice that 'myArray' is our offset
  addi $t0, $t0, 4        # Similar to a pointer in C, adding 4 moves us to the next space in our array.
                          # Given that the array stores values next to each other, we can increment in this fashion.
                          
  # Store $s1, which holds 10
  sw $s1, myArray($t0)
  addi $t0, $t0, 4        # Increment by 4 bytes (the size of a word) to shift to the next available space. 
  
  # Store $s2, which holds 12
  sw $s2, myArray($t0)
  
  
  # Now, let's retrieve our values from RAM
  add $t0, $zero, $zero  # Clear $t0
  
  # Go through the same process as shown above, except we use 'lw' not 'sw'
  lw $t1, myArray($t0)   # Load 4 into $t1
  addi $t0, $t0, 4
  
  lw $t2, myArray($t0)   # Load 10 into $t2
  addi $t0, $t0, 4
  
  lw $t3, myArray($t0)   # Load 12 into $t3
  
  
  # Print our values
  li   $v0, 1
  move $a0, $t1  # Print $t1 (4)
  syscall
  
  # Newline
  li $v0, 11
  li $a0, '\n'
  syscall
  
  
  li   $v0, 1
  move $a0, $t2  # Print $t2 (10)
  syscall
  
  # Newline
  li $v0, 11
  li $a0, '\n'
  syscall
  
  
  li   $v0, 1
  move $a0, $t3  # Print $t3 (12)
  syscall


  # Terminating Program
  li $v0, 10
  syscall