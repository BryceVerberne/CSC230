# Title:  Macros
# Desc:   This file contains a collection of assembly macros for common tasks.
# Author: Bryce Verberne
# Data:   02/21/2023



# Print a string to the console
.macro printString (%s)
  la $a0, %s
  li $v0, 4
  syscall
.end_macro
  
# Read an integer from the console 
.macro readInt (%t)
  li $v0, 5
  syscall 
  move %t, $v0
.end_macro
   
# Terminate the program
.macro done
  li $v0, 10
  syscall
.end_macro
  
# Print an integer to the console 
.macro printInt (%t)
  move $a0, %t
  li $v0, 1
  syscall
.end_macro
   
# Print a newline to the console
.macro printNewLine
  li $a0, '\n'
  li $v0, 11
  syscall
.end_macro

# Sleep: Slow the execution time of a running program
.macro sleep
  li $a0, 1000
  li $v0, 32
  syscall
.end_macro