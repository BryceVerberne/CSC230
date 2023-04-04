# Title:  Average
# Desc:   This program demonstrates how to find the average of an array of integers
# Author: Bryce Verberne
# Title:  04/04/2023



.data 
  array:  .word 10, 2, 9
  length: .word 3  # This specifies the length of 'array'. We have 3, since there are three values in 'array'.
  sum:    .word 0
  avg:    .word 0
  
  message1: .asciiz "This is the sum: "
  message2: .asciiz "\nThis is the average: "

.text
  .globl main
main:
    
  la $t0, array            # Load the base address of 'array' into '$t0'
  li $t1, 0                # i = 0
  lw $t2, length           # Store the value of length into $t2 from RAM
  li $t3, 0                # Sum = 0
  
  # Create our loop to find the sum of 'array'
  sumLoop:
    lw $t4, ($t0)          # $t4 = array[i]
    
    # Take the value in $t4, and add it to $t3 (sum += array[i])
    add $t3, $t3, $t4
    
    # Increment our index by 1
    add $t1, $t1, 1
    
    # Add four to the base address after every iteration to point to the next element
    add $t0, $t0, 4
  
    blt $t1, $t2, sumLoop  # If $t1(i) < $t2(length), then go back to 'sumLoop'
    
    
  sw $t3, sum              # Store the sum value in our 'sum' variable.
    
  # Calculate the average
  div $t5, $t3, $t2        # sum / length = average
  sw  $t5, avg             # Store the average in RAM


  # Display the sum
  # Print 'message1' - "This is the sum: "
  li $v0, 4
  la $a0, message1
  syscall
  
  # Print 'sum' - "This is the sum: <'sum'>"
  li $v0, 1
  lw $a0, sum
  syscall
  
  # Display the average
  # Print 'message2' - "This is the average: "
  li $v0, 4
  la $a0, message2
  syscall
  
  # Print 'avg' - "This is the average: <'avg'>"
  li $v0, 1
  lw $a0, avg
  syscall

  
  # Terminating Program
  li $v0, 10
  syscall