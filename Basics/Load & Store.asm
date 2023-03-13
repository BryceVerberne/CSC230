# Title:  Load & Store 
# Desc:   This program prompts the user for input, preforms arithmetic on the input, and returns the result.
# Author: Bryce Verberne
# Date:   02/14/2023



.data
  # Create string variables for prompting user
  num1Prompt: .asciiz "Please enter the first number: "
  num2Prompt: .asciiz "Please enter the second number: "
  num3Prompt: .asciiz "Please enter the third number: "

  # Create string variables for final output
  result:     .asciiz "Result: "
  op1:        .asciiz  " + "
  op2:        .asciiz  " - "
  op3:        .asciiz  " = "

.text 
  .globl main
main: 

  # Prompt user for integers and store input
  la $a0, num1Prompt  # Prep print num1Prompt
  li $v0, 4           # ...
  syscall             # Execute print. Output: Please enter the first number: 

  li   $v0, 5         # Prep to read integer 1 (num1)
  syscall             # Read integer
  move $t0, $v0       # Move integer into $t0


  la $a0, num2Prompt  # Prep print num2Prompt
  li $v0, 4           # ...
  syscall             # Execute print. Output: Please enter the second number: 

  li   $v0, 5         # Prep to read integer 2 (num2)
  syscall             # Read integer
  move $t1, $v0       # Moving integer into $t1

  la $a0, num3Prompt  # Prep print num3Prompt
  li $v0, 4           # ...
  syscall             # Execute print. Output: Please enter the third number: 

  li   $v0, 5         # Prep to read integer 3 (num3)
  syscall             # Read integer
  move $t2, $v0       # Move integer into $t2

  la $a0, result      # Prep print result 
  li $v0, 4           # ...
  syscall             # Execute Print. Output: Result: 

  # Output Results
  move $a0, $t0       # Prep print num1
  li   $v0, 1         # ...
  syscall             # Execute Print. Output: num1

  la $a0, op1         # Prep print op1
  li $v0, 4           # ...
  syscall             # Execute Print. Output: num1 + 

  move $a0, $t1       # Prep print num2
  li   $v0, 1         # ...
  syscall             # Execute Print. Output: num1 + num2 

  la $a0, op2         # Prep print op2
  li $v0, 4           # ...
  syscall             # Execute Print. Output: num1 + num2 - 

  move $a0, $t2       # Prep print num3
  li   $v0, 1         # ...
  syscall             # Execute Print. Output: num1 + num2 - num3

  la $a0, op3         # Prep print op3
  li $v0, 4           # ...
  syscall             # Execute Print. Output: num1 + num2 - num3 = 

  # Do processing
  add $t1, $t0, $t1   # Add $t0 and $t1, then store in $t1 (num1 + num2)
  sub $t0, $t1, $t2   # Subtract $t1 adn $t2, then store in $t0 (num1 + num2 - num3)

  # Output Final Calculation
  move $a0, $t0       # Prep print of result
  li $v0, 1           # ...
  syscall             # Execute Print.

  li $a0, '\n'        # Prep print of \n cause it looks nice
  li $v0, 11          # ...
  syscall             # Execute Print.


  # Terminate the program
  li $v0, 10
  syscall
