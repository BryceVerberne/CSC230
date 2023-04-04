#Title:   Programming Elements Activity
# Desc:   This program requests input, manipulates that input, and outputs the result.
# Author: Bryce Verberne
# Date:   02/07/2023



.data                # Tells assembler what follows is data

  # Create string variables that prompt the user and provide a result  
  prompt1: .asciiz "Please enter the first number: " 
  prompt2: .asciiz "Please enter the second number: "
  result: .asciiz "The sum of your numbers is: "

.text                # Tells assembler what follows is code
.globl main
main:                # Starting point
  
  # Request and receive input, then load registers $s0 and $s1
  la $a0, prompt1    # Load the string address into register $a0
  li $v0, 4          # The code to print our prompt1 string
  syscall            # Make the request
  
  li $v0, 5          # The code to request the system to read an integer
  syscall            # Make the request
  
  move $s0, $v0      # Move the value entered by the user to $s0
  
  la $a0, prompt2    # Load the string address into register $a0
  li $v0, 4          # The code to print our prompt2 string
  syscall            # Make the request
  
  li $v0, 5          # The code to request the system to read an integer
  syscall            # Make the request
  
  move $s1, $v0      # Move the value entered by the user to $s1

  # Do processing
  add $s2, $s0, $s1  # Add $s0 and $s1 and store it in $s2
  
  # Output results
  la $a0, result     # Load the string address into register $a0
  li $v0, 4          # The code to print our result string
  syscall            # Make the request
  
  move $a0, $s2      # Move $s2 to $a0
  li $v0, 1          # The code to print the value of register $s2
  syscall            # Make the request
  
  li $v0, 10         # Load up a code to end program
  syscall            # Make the request
