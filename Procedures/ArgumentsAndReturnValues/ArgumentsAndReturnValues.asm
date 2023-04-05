# Title:  Arguments & Return Values
# Desc:   This program demonstrates how to pass arguments to & return values from procedures.
# Author: Bryce Verberne
# Date:   03/17/2023



# Info:
#  - We use the $a0 - $a3 registers to pass arguments to procedures.
#  - We use the $v0 - $v1 registers to return values from procedures.

.data
  message: .asciiz "The value of 50 + 100 is: "
  
.text
  .globl main
main:
  li $a1, 50         # This is our first argument (50)
  li $a2, 100        # This is our second argument (100)

  jal addNumbers     # Call addNumbers procedure


  la $a0, message    # Print our message
  li $v0, 4
  syscall
  
  li   $v0, 1        # Print our integer result
  move $a0, $v1      # Move our return value to the argument register
  syscall
  

  # Terminating Program
  li $v0, 10
  syscall
  
  
addNumbers:
  add $v1, $a1, $a2  # Store 50 + 100 in $v1 so they can be returned to main.
  
  jr  $ra            # Return to main procedure