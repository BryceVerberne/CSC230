# Title:  Printing Arrays w/ Loops
# Desc:   This program demonstrates how to print the contents of an array with a while loop
# Author: Bryce Verberne
# Date:   04/04/2023



.data
  myArray:  .space 12  # We want to store three integers, so we need 12 bytes. 
  message1: .asciiz "\nAt the position "
  message2: .asciiz ", this is our value: "

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
  sw   $s0, myArray($t0)  # Store $s0, which holds 4
  addi $t0, $t0, 4        
                          
  sw   $s1, myArray($t0) # Store $s1, which holds 10
  addi $t0, $t0, 4
  
  sw $s2, myArray($t0)   # Store $s2, which holds 12
  
  
  add $t0, $zero, $zero  # Clear our index register ($t0)
  
  # Create our loop
  while:
    beq $t0, 12, exit    # If the value of $t0 = 12, then exit
    
    lw $t1, myArray($t0) # Load array value into $t1
    
    # Print our messages & value
    # Print 'message1' - "At the position "
    li $v0, 4
    la $a0, message1
    syscall
    
    # Print '$t0' - "At the position <$t0>"
    li   $v0, 1
    move $a0, $t0
    syscall
    
    # Print 'message2' - "At the position <$t0>, this is our value: "
    li $v0, 4
    la $a0, message2
    syscall
    
    # Print '$t1' (our array value) - "At the position <$t0>, this is our value: <$t1>"
    li   $v0, 1
    move $a0, $t1
    syscall
    
    # Increment $t0 to point to the next location in our array
    addi $t0, $t0, 4
    
    b while
  exit:
  
  
  # Terminating Program
  li $v0, 10
  syscall