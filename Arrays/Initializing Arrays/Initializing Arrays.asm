# Title:  Initializing Arrays
# Desc:   This program demonstrates how to initialize elements into an array with different techniques
# Author: Bryce Verberne
# Date:   04/04/2023



.data
  array1:   .word 100:5     # Store 3 values that are initialized to 100 into array1
  array2:   .word 22 5 936  # Store 3 values into array2
  message1: .asciiz "The following are the values from array1:"
  message2: .asciiz "\n\nThe following are the values from array2:"

.text
  .globl main
main:
  # Clear our index ($t0)
  add $t0, $zero, $zero  
  
  # Print 'message1' - "The following are the values from array1:"
  li $v0, 4
  la $a0, message1
  syscall
  
  # Create our loop
  while1:
    # Change 12 to 20 since we are printing 5 values (5elements x 4bytes = 20)
    beq $t0, 20, exit1  # If the value of $t0 = 20, then exit
    
    lw $t1, array1($t0) # Load array value into $t1
    
    # Newline
    li $v0, 11
    li $a0, '\n'
    syscall
    
    # Print our value
    li   $v0, 1
    move $a0, $t1
    syscall
    
    # Increment $t0 to point to the next location in our array
    addi $t0, $t0, 4
    
    b while1
  exit1:
  
  
  # Clear our index ($t0)
  add $t0, $zero, $zero  
  
  # Print 'message2' - "The following are the values from array2:"
  li $v0, 4
  la $a0, message2
  syscall 
  
  # Create our loop
  while2:
    beq $t0, 12, exit2  # If the value of $t0 = 12, then exit
    
    lw $t1, array2($t0) # Load array value into $t1
    
    # Newline
    li $v0, 11
    li $a0, '\n'
    syscall
    
    # Print our value
    li   $v0, 1
    move $a0, $t1
    syscall
    
    # Increment $t0 to point to the next location in our array
    addi $t0, $t0, 4
    
    b while2
  exit2:
  
  
  
  # Terminating Program
  li $v0, 10
  syscall